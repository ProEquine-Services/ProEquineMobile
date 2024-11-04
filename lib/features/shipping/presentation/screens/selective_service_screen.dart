import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/home/domain/cubits/home_cubit.dart';
import 'package:proequine_dev/features/shipping/data/selective_service_response_model.dart';
import 'package:proequine_dev/features/shipping/domain/shipping_cubit.dart';
import 'package:proequine_dev/features/shipping/presentation/screens/selective_service_export_screen.dart';
import 'package:proequine_dev/features/shipping/presentation/screens/selective_service_import_screen.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../../transports/presentation/widgets/booking_loading_widget.dart';
import '../widgets/empty_selective_service.dart';
import '../widgets/selective_service_widget.dart';
import 'create_export_screen.dart';
import 'create_import_screen.dart';

class SelectiveServicesScreen extends StatefulWidget {
  final String type;

  const SelectiveServicesScreen({super.key, required this.type});

  @override
  State<SelectiveServicesScreen> createState() =>
      _SelectiveServicesScreenState();
}

class _SelectiveServicesScreenState extends State<SelectiveServicesScreen> {
  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  ScrollController scrollController = ScrollController();
  ShippingCubit cubit = ShippingCubit();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool? isEmailVerified = false;

  @override
  void initState() {
    context
        .read<ShippingCubit>()
        .getAllSelectiveServices(limit: 10, type: widget.type);
    super.initState();
  }

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<HomeCubit>();
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    isEmailVerified ??= false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text("Shipping ${widget.type}",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? Colors.white
                    : AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.transparent
            : AppColors.backgroundColorLight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  if (isEmailVerified!) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    myCubit.getAllSelectiveServices(
                        limit: 4, showOnHomePage: true);
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.blackLight,
                ),
              )),
        ),
        actions: [
          TextButton(
              onPressed: () {
                checkVerificationStatus().then((verified) {
                  if (!verified) {
                    // If the account is not verified, show a dialog after a delay.
                    Future.delayed(const Duration(milliseconds: 50), () {
                      showUnverifiedAccountDialog(
                        context: context,
                        isThereNavigationBar: true,
                        onPressVerify: () {
                          Navigator.pushNamed(context, verifyEmail,
                              arguments: VerifyEmailRoute(
                                  type: widget.type,
                                  email: AppSharedPreferences
                                      .userEmailAddress))
                              .then((value) {});
                        },
                      );
                    });
                  } else {
                    if (widget.type == 'Import') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateImportScreen()));
                    } else if (widget.type == 'Export') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateExportScreen()));
                    }
                  }
                });


              },
              child: const Text(
                'Add',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Color(0xFFC48636),
                  fontSize: 14,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 90.h,
              child: BlocConsumer<ShippingCubit, ShippingState>(
                bloc: context.read<ShippingCubit>(),
                listener: (context, state) {
                  if (state is GetAllSelectiveServicesError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  } else if (state is GetAllSelectiveServicesSuccessfully) {
                    Print("refreshController.refreshCompleted()");
                    refreshController.refreshCompleted();

                    if (state.model.length >= state.count) {
                      refreshController.loadNoData();
                      Print("refreshController.loadNoData();");
                    } else {
                      refreshController.loadComplete();
                      Print("refreshController.loadComplete()");
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetAllSelectiveServicesError) {
                    return Container();
                  } else if (state is GetAllSelectiveServicesLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 20),
                      child: TransportsLoadingWidget(
                        shipping: false,
                      ),
                    );
                  } else if (state is GetAllSelectiveServicesSuccessfully) {
                    if (state.model.isEmpty) {
                      return EmptySelectiveServiceWidget(
                        type: widget.type,
                      );
                    } else {
                      return _smartRefresher(
                        state.model,
                      );
                    }
                  }

                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _smartRefresher(
    List<SelectiveServiceModel> transports,
  ) {
    return SizedBox(
      // height: 90.0.h,
      child: Scrollbar(
        controller: scrollController,
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(
            waterDropColor: AppColors.gold,
          ),
          onRefresh: () {
            context.read<ShippingCubit>().getAllSelectiveServices(
                limit: 8, isRefreshing: true, type: widget.type);
            return;
          },
          onLoading: () {
            BlocProvider.of<ShippingCubit>(context).getAllSelectiveServices(
                limit: 8, loadMore: true, type: widget.type
                // fullName: widget.followerName,
                );
            return;
          },
          child: buildTransportsList(transports),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("".tra);
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!".tra);
              } else if (mode == LoadStatus.canLoading) {
                body = const SizedBox.shrink();
              } else {
                body = Center(child: Text("".tra));
              }
              return body;
            },
          ),
        ),
      ),
    );
  }

  buildTransportsList(List<SelectiveServiceModel> services) {
    return ListView.builder(
        controller: scrollController,
        itemCount: services.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == (services.length)) {
            return SizedBox(
              height: 4.5.h,
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: GestureDetector(
                  onTap: () {
                    checkVerificationStatus().then((verified) {
                      if (!verified) {
                        // If the account is not verified, show a dialog after a delay.
                        Future.delayed(const Duration(milliseconds: 50), () {
                          showUnverifiedAccountDialog(
                            context: context,
                            isThereNavigationBar: true,
                            onPressVerify: () {
                              Navigator.pushNamed(context, verifyEmail,
                                      arguments: VerifyEmailRoute(
                                          type: widget.type,
                                          email: AppSharedPreferences
                                              .userEmailAddress))
                                  .then((value) {});
                            },
                          );
                        });
                      } else {
                        if (services[index].type == 'Import') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectiveServiceImportScreen(
                                        model: services[index],
                                      )));
                        } else if (services[index].type == 'Export') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectiveServiceExportScreen(
                                        model: services[index],
                                      )));
                        }
                      }
                    });
                  },
                  child: SelectiveServiceWidget(
                    title: services[index].title!,
                    selectiveId: services[index].selectiveCode.toString(),
                    transportType: services[index].type,
                    status: services[index].availableForBooking ?? true
                        ? 'Book Now'
                        : 'Closed',
                    from: services[index].fromCountry,
                    to: services[index].toCountry,
                    date: services[index].startDate,
                  ),
                ),
              ),
            ],
          );
        });
  }
}

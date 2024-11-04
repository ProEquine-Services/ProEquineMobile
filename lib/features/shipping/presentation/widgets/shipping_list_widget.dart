
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/shipping/data/user_shipping_response_model.dart';
import 'package:proequine_dev/features/shipping/domain/shipping_cubit.dart';
import 'package:proequine_dev/features/shipping/presentation/widgets/shipping_widget_item.dart';
import 'package:proequine_dev/features/transports/presentation/widgets/booking_loading_widget.dart';
import 'package:proequine_dev/features/transports/presentation/widgets/empty_local_transport_widget.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../invoices/presentation/screens/user_invoices_screen.dart';
import '../screens/edit_export_screen.dart';
import '../screens/edit_import_screen.dart';

class ShippingListWidget extends StatefulWidget {
  final String status;

  const ShippingListWidget({super.key, required this.status});

  @override
  ShippingListWidgetState createState() => ShippingListWidgetState();
}

class ShippingListWidgetState extends State<ShippingListWidget> {
  ScrollController scrollController = ScrollController();
  ShippingCubit cubit = ShippingCubit();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context
        .read<ShippingCubit>()
        .getAllShippingRequests(limit: 10, status: widget.status);
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: BlocConsumer<ShippingCubit, ShippingState>(
        bloc: context.read<ShippingCubit>(),
        listener: (context, state) {
          if (state is GetAllShippingRequestsError) {
            RebiMessage.error(msg: state.message!, context: context);
          } else if (state is GetAllShippingRequestsSuccessfully) {
            Print("refreshController.refreshCompleted()");
            refreshController.refreshCompleted();

            if (state.transports.length >= state.count) {
              refreshController.loadNoData();
              Print("refreshController.loadNoData();");
            } else {
              refreshController.loadComplete();
              Print("refreshController.loadComplete()");
            }
          }
        },
        builder: (context, state) {
          if (state is GetAllShippingRequestsError) {
            return Container();
          } else if (state is GetAllShippingRequestsLoading) {
            return const TransportsLoadingWidget(shipping: true,);
          } else if (state is GetAllShippingRequestsSuccessfully) {
            if (state.transports.isEmpty) {
              return const EmptyLocalTransportWidget(
                type: 'shipping',
              );
            } else {
              return _smartRefresher(
                state.transports,
              );
            }
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  _smartRefresher(
    List<ShippingModel> shippingRequests,
  ) {
    return SizedBox(
      // height: 100.0.h,
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
            context.read<ShippingCubit>().getAllShippingRequests(
                  limit: 8,
                  isRefreshing: true,
                  status: widget.status,
                );
            return;
          },
          onLoading: () {
            BlocProvider.of<ShippingCubit>(context).getAllShippingRequests(
              limit: 8,
              loadMore: true,
              status: widget.status,
              // fullName: widget.followerName,
            );
            return;
          },
          child: buildTransportsList(shippingRequests),
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

  buildTransportsList(List<ShippingModel> shippingRequests) {
    return ListView.builder(
      controller: scrollController,
      itemCount: shippingRequests.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == (shippingRequests.length)) {
          return SizedBox(
            height: 4.5.h,
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: GestureDetector(
                onTap: () {
                  if (shippingRequests[index].status == 'Completed') {
                  } else if (shippingRequests[index].status == 'Confirmed' ||
                      shippingRequests[index].status == 'InProgress') {
                    String formatDate(DateTime date) {
                      // Define the date format
                      final dateFormat = DateFormat("MMMM d, yyyy");
                      // Format the date
                      final formattedDate = dateFormat.format(date);
                      return formattedDate;
                    }

                    showGlobalBottomSheet(
                        context: context,
                        title: shippingRequests[index].status!,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 19),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Service",
                                    style: AppStyles.summaryTitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    formatDate(DateTime.parse(shippingRequests[index].pickUpDate!)),
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                  Text(
                                    shippingRequests[index].type!,
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pick up",
                                    style: AppStyles.summaryTitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    shippingRequests[index]
                                        .place
                                        ?.name
                                        .toString() ??
                                        '',
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                  Text(
                                    "${shippingRequests[index].pickUpContactName} • ${shippingRequests[index].pickUpPhoneNumber}",
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Horses",
                                    style: AppStyles.summaryTitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    shippingRequests[index]
                                        .numberOfHorses
                                        .toString(),
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                ],
                              ),
                              shippingRequests[index].notes != null
                                  ? Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const CustomDivider(),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Notes",
                                        style:
                                        AppStyles.summaryTitleStyle,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        shippingRequests[index].notes!,
                                        style:
                                        AppStyles.summaryDesStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  : const SizedBox()
                            ],
                          ),
                        ));
                  }
                  else if (shippingRequests[index].status ==
                      'Waiting For Payment') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const UserInvoicesScreen()));
                  }


                  if (shippingRequests[index].status == 'Draft' ||
                      shippingRequests[index].status == 'Pending') {
                    if (shippingRequests[index].type == 'Import') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditImportScreen(
                                  model: shippingRequests[index],
                                  isFromEditing: shippingRequests[index].isBelongToSelective!,
                                  estimatedDate:
                                      shippingRequests[index].pickUpDate!)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditExportScreen(
                                  isFromEditing: shippingRequests[index].isBelongToSelective!,
                                  model: shippingRequests[index],
                                  estimatedDate:
                                      shippingRequests[index].pickUpDate!)));
                    }
                  }
                },
                child: ShippingWidgetItem(
                  status: shippingRequests[index].status!,
                  date: shippingRequests[index].pickUpDate,
                  horsesCount: shippingRequests[index].numberOfHorses,
                  from: shippingRequests[index].pickUpCountry ?? '1',
                  to: shippingRequests[index].dropCountry ?? '2',
                  transportType: shippingRequests[index].type,
                  bookingId: shippingRequests[index].shippingCode.toString(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

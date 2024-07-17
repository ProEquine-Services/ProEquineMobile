import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/invoices/presentation/screens/user_invoices_screen.dart';
import 'package:proequine/features/transports/domain/transport_cubit.dart';
import 'package:proequine/features/transports/presentation/screens/edit_trip_screen.dart';
import 'package:proequine/features/transports/presentation/widgets/booking_loading_widget.dart';
import 'package:proequine/features/transports/presentation/widgets/empty_local_transport_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../data/create_transport_response_model.dart';
import 'transport_widget.dart';

class AllTransportsWidget extends StatefulWidget {
  final String status;

  const AllTransportsWidget({super.key, required this.status});

  @override
  AllTransportsWidgetState createState() => AllTransportsWidgetState();
}

class AllTransportsWidgetState extends State<AllTransportsWidget> {
  ScrollController scrollController = ScrollController();
  TransportCubit cubit = TransportCubit();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context
        .read<TransportCubit>()
        .getAllTransports(limit: 10, status: widget.status);
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
      child: BlocConsumer<TransportCubit, TransportState>(
        bloc: context.read<TransportCubit>(),
        listener: (context, state) {
          if (state is GetAllTransportsError) {
            RebiMessage.error(msg: state.message!, context: context);
          } else if (state is GetAllTransportsSuccessfully) {
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
          if (state is GetAllTransportsError) {
            return Container();
          } else if (state is GetAllTransportsLoading) {
            return const TransportsLoadingWidget(
              shipping: false,
            );
          } else if (state is GetAllTransportsSuccessfully) {
            if (state.transports.isEmpty) {
              return const EmptyLocalTransportWidget(
                type: 'transport',
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
    List<TransportModel> transports,
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
            context.read<TransportCubit>().getAllTransports(
                  limit: 8,
                  isRefreshing: true,
                );
            return;
          },
          onLoading: () {
            BlocProvider.of<TransportCubit>(context).getAllTransports(
              limit: 8,
              loadMore: true,
              status: widget.status,
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

  buildTransportsList(List<TransportModel> transports) {
    return ListView.builder(
        controller: scrollController,
        itemCount: transports.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == (transports.length)) {
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
                    if (transports[index].status == 'Completed') {
                    } else if (transports[index].status == 'Confirmed' ||
                        transports[index].status == 'InProgress' ||
                        transports[index].status == 'Rejected' ||
                        transports[index].status == 'Canceled') {
                      String formatDate(DateTime date) {
                        final dateFormat = DateFormat("MMMM d, yyyy");
                        final formattedDate = dateFormat.format(date);
                        return formattedDate;
                      }

                      showGlobalBottomSheet(
                          context: context,
                          title: transports[index].status!,
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 2),
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
                                      "${formatDate(DateTime.parse(transports[index].pickUpDate!))} • ${transports[index].pickUpTime!}",
                                      style: AppStyles.summaryDesStyle,
                                    ),
                                    Text(
                                      transports[index].type!,
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
                                      transports[index]
                                              .pickPlace
                                              ?.name
                                              .toString() ??
                                          '',
                                      style: AppStyles.summaryDesStyle,
                                    ),
                                    Text(
                                      "${transports[index].pickUpContactName} • ${transports[index].pickUpPhoneNumber}",
                                      style: AppStyles.summaryDesStyle,
                                    ),
                                  ],
                                ),
                                const CustomDivider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Drop off",
                                      style: AppStyles.summaryTitleStyle,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      transports[index]
                                              .dropPlace
                                              ?.name
                                              .toString() ??
                                          '',
                                      style: AppStyles.summaryDesStyle,
                                    ),
                                    Text(
                                      "${transports[index].dropContactName} • ${transports[index].dropPhoneNumber}",
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
                                      transports[index]
                                          .numberOfHorses
                                          .toString(),
                                      style: AppStyles.summaryDesStyle,
                                    ),
                                  ],
                                ),
                                transports[index].notes != null
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
                                                transports[index].notes!,
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
                    } else if (transports[index].status ==
                        'Waiting For Payment') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserInvoicesScreen()));
                    } else {
                      if (transports[index].isBelongToSelective!) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditTripScreen(
                                      model: transports[index],
                                      selectiveRequest: true,
                                      type: transports[index].type,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditTripScreen(
                                      model: transports[index],
                                      selectiveRequest: false,
                                      type: transports[index].type,
                                    )));
                      }
                    }
                  },
                  child: TransportWidget(
                    status: transports[index].status!,
                    date: transports[index].pickUpDate!,
                    horsesCount: transports[index].numberOfHorses,
                    from: transports[index].pickPlace?.status == 'Dummy'
                        ? "New Place"
                        : transports[index].pickPlace?.code ?? 'New Place',
                    to: transports[index].dropPlace?.status == 'Dummy'
                        ? "New Place"
                        : transports[index].dropPlace?.code ?? 'New Place',
                    transportType: transports[index].type,
                    bookingId: transports[index].transportCode,
                  ),
                ),
              ),
            ],
          );
        });
  }
}

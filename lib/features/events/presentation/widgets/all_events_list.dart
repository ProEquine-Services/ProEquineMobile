import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../data/events_response_model.dart';
import 'eventlistitem.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({Key? key}) : super(key: key);

  @override
  AllEventsScreenState createState() => AllEventsScreenState();
}

class AllEventsScreenState extends State<AllEventsScreen> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  EventCubit cubit = EventCubit();

  @override
  void initState() {
    super.initState();
    cubit.getAllEvents(perPage: 8);
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<EventCubit, EventState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is AllEventsSuccessful) {
              refreshController.refreshCompleted();

              if (state.currentPage == cubit.lastPageForEvents) {
                refreshController.loadNoData();
              } else {
                refreshController.loadComplete();
              }
            }
          },
          builder: (context, state) {
            if (state is AllEventsError) {
              RebiMessage(msg: state.message!);
            } else if (state is AllEventsLoading) {
              // return const GridLoadingShimmer();
              return const LoadingCircularWidget();
            } else if (state is AllEventsSuccessful) {
              if (state.events!.isEmpty) {
                return const SizedBox.shrink();
              } else {
                return _smartRefresher(state.events!);
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _smartRefresher(List<EventsResponseModel> events) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(
        waterDropColor: AppColors.gold,
      ),
      onRefresh: () {
        cubit.getAllEvents(isRefreshing: true);
      },
      onLoading: () {
        cubit.getAllEvents(loadMore: true);
      },
      child: _buildListAllEvents(events),
      footer: CustomFooter(
        builder: (BuildContext? context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("No more Events".tr());
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!".tr());
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more".tr());
          } else if (events.length < 10) {
            body = const Text("");
          } else {
            body = Text("No more Events".tr());
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
    );
  }

  _buildListAllEvents(List<EventsResponseModel> events) {
    return ListView.builder(
      // controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      padding: EdgeInsets.only(
        top: 2.0.h,
        bottom: 2.0.h,
        left: 10,
        right: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == (events.length)) {
          return SizedBox(
            height: 4.5.h,
          );
        }
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: EventListItem(
              imageUrl:
                 events[index].eventImage??'https://proequineimagestore.blob.core.windows.net/proequineimages/Testing8',
              eventTitle: events[index].eventTitle??'',
              //Todo add location here instead of time (Apis)
              date: events[index].eventDate!.substring(0,10),
            ));
      },
    );
  }
}

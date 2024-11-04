import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/notifications/data/notifications_response_model.dart';
import 'package:proequine_dev/features/notifications/domain/notifications_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../main.dart';
import '../../../nav_bar/domain/inbox_badge.dart';
import '../widgets/empty_notifications_widget.dart';
import '../widgets/notification_widget.dart';
import '../widgets/notifications_loading_widget.dart';

class UserNotificationScreen extends StatefulWidget {
  const UserNotificationScreen({super.key});

  @override
  UserNotificationScreenState createState() => UserNotificationScreenState();
}

class UserNotificationScreenState extends State<UserNotificationScreen> {
  ScrollController scrollController = ScrollController();

  NotificationsCubit cubit = NotificationsCubit();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<ChangeBoolCubit>(MyApp.navigatorKey.currentContext!)
        .changeStatusToFalse();
    context.read<NotificationsCubit>().getUserNotifications(limit: 10);
    super.initState();
  }

  bool _isNavigating = false;


  void _handleNotificationBody(String body) {
    if (_isNavigating) {
      print('Already navigating, skipping...');
      return;
    }
    _isNavigating = true;

    final context = MyApp.navigatorKey.currentContext!;
    switch (body) {
      case 'Horses':
        Navigator.pushNamed(context, horses);
        break;
      case 'HorseAssociation':
        Navigator.pushNamed(context, horseAssociationRequests);
        break;
      case 'HorseAssociationAccept':
        Navigator.pushNamed(context, horseAssociation);
        break;
      case 'HorseAssociationReject':
        Navigator.pushNamed(context, horseAssociation);
        break;
      case 'HorseDocumentsApproval':
        Navigator.pushNamed(context, horseAssociation);
        break;
      case 'HorseDocumentsRejection':
        Navigator.pushNamed(context, horseAssociation);
        break;
      case 'PaymentsWalletUpdate':
        Navigator.pushNamed(context, wallet);
        break;
      case 'PaymentTransactionsApproved':
        Navigator.pushNamed(context, wallet);
        break;
      case 'PaymentTransactionsRejected':
        Navigator.pushNamed(context, wallet);
        break;
      case 'SupportRequestAvailable':
        Navigator.pushNamed(context, support);
        break;
      case 'TransportJobActive':
        Navigator.pushNamed(context, transportation);
        break;
      case 'TransportJobRejected':
        Navigator.pushNamed(context, transportation);
        break;
      case 'TransportJobAccepted':
        Navigator.pushNamed(context, transportation);
        break;
      case 'ShippingJobAccepted':
        Navigator.pushNamed(context, shipping);
        break;
      case 'ShippingJobActive':
        Navigator.pushNamed(context, shipping);
        break;
      case 'ShippingJobRejected':
        Navigator.pushNamed(context, shipping);
        break;
      default:
        print('Unknown notification body: $body');
        break;
    }

    Future.delayed(const Duration(seconds: 1), () {
      _isNavigating = false;
    });
  }

  @override
  void dispose() {
    refreshController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Notifications",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColorLight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.backgroundColor,
                ),
              )),
        ),
      ),
      body: SizedBox(
        // height: 100.h,
        child: BlocConsumer<NotificationsCubit, NotificationsState>(
          bloc: context.read<NotificationsCubit>(),
          listener: (context, state) {
            if (state is GetNotificationsError) {
              RebiMessage.error(msg: state.message!, context: context);
            } else if (state is GetNotificationsSuccessfully) {
              Print("refreshController.refreshCompleted()");
              refreshController.refreshCompleted();

              if (state.notifications.length >= state.count) {
                refreshController.loadNoData();
                Print("refreshController.loadNoData();");
              } else {
                refreshController.loadComplete();
                Print("refreshController.loadComplete()");
              }
            }
          },
          builder: (context, state) {
            if (state is GetNotificationsError) {
              return Container();
            } else if (state is GetNotificationsLoading) {
              return const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    NotificationsLoadingWidget(),
                  ],
                ),
              );
            } else if (state is GetNotificationsSuccessfully) {
              if (state.notifications.isEmpty) {
                return EmptyNotificationsWidget();
              } else {
                return _smartRefresher(
                  state.notifications,
                );
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _smartRefresher(
    List<NotificationModel> notification,
  ) {
    return SizedBox(
      // height: 85.0.h,
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
            context.read<NotificationsCubit>().getUserNotifications(
                  limit: 10,
                  isRefreshing: true,
                );
            return;
          },
          onLoading: () {
            BlocProvider.of<NotificationsCubit>(context).getUserNotifications(
              limit: 10,
              loadMore: true,
              // fullName: widget.followerName,
            );
            return;
          },
          child: buildNotificationsList(notification),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("No more notifications".tra);
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!".tra);
              } else if (mode == LoadStatus.canLoading) {
                body = const SizedBox.shrink();
              } else {
                body = Center(child: Text("No more notifications".tra));
              }
              return body;
            },
          ),
        ),
      ),
    );
  }

  buildNotificationsList(List<NotificationModel> notifications) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              controller: scrollController,
              itemCount: notifications.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == (notifications.length)) {
                  return SizedBox(
                    height: 4.5.h,
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 5),
                  child: GestureDetector(
                    onTap: (){
                      _handleNotificationBody(notifications[index].type!);
                    },
                    child: NotificationWidget(
                      type: notifications[index].type,
                      date: notifications[index].dateTime,
                      content: notifications[index].content?.en ?? 'whatever',
                      title: notifications[index].title?.en ?? 'Title',
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

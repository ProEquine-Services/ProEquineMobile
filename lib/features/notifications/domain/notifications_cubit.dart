import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:proequine/features/notifications/data/notifications_response_model.dart';
import 'package:proequine/features/notifications/domain/repo/notifications_repository.dart';
import 'package:proequine/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/constants/routes/routes.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../nav_bar/domain/inbox_badge.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  int? limit = 8;
  int total = 0;
  List<dynamic> notifications = [];
  int count = 0;
  int offset = 0;
  late RefreshController refreshController;

  // final MethodChannel _channel = const MethodChannel('OneSignal#notifications');
  // Future<bool> requestPermission(bool fallbackToSettings) async {
  //   return await _channel.invokeMethod("OneSignal#requestPermission",
  //       {'fallbackToSettings': fallbackToSettings});
  // }

  Future<void> configOneSignal() async {
    Print("Start Config");
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    OneSignal.initialize('ef8bd521-54d4-4a21-b1f3-654755149b50');
    await OneSignal.Notifications.requestPermission(true);
    await OneSignal.User.lifecycleInit();
    await OneSignal.User.pushSubscription.lifecycleInit();
    await OneSignal.Notifications.lifecycleInit();

    final id = OneSignal.User.getOnesignalId();
    // final userId=OneSignal.User.
    await id.then((value) {
      AppSharedPreferences.setDeviceId = OneSignal.User.pushSubscription.id!;
      Print("Theee value is $value");
      Print('The User id is ${OneSignal.User.pushSubscription.id!}' );
    }).catchError((error) {
      print('Error: $error');
    });



    OneSignal.Notifications.removeNotification(1);

    OneSignal.Notifications.removeGroupedNotifications("group5");

    // OneSignal.Notifications.addClickListener((event) {
    //
    //   print("all events: $event");
    //   print("additional data is: ${event.notification.additionalData}");
    //   print("body is: ${event.notification.body}");
    // });

    OneSignal.User.pushSubscription.addObserver((state) {
      Print("subsssssss");
      print(OneSignal.User.pushSubscription.optedIn);

      print(OneSignal.User.pushSubscription.id);
      AppSharedPreferences.setDeviceId = OneSignal.User.pushSubscription.id!;
      print("Device Id From OneSignal inside the pushSubs${AppSharedPreferences.getDeviceId}");
      print("Token ${OneSignal.User.pushSubscription.token}");
      print(state.current.jsonRepresentation());
    });
    // OneSignal.User.

    OneSignal.User.addObserver((state) {
      var userState = state.jsonRepresentation();
      Print("Printttt user device id ${state.current.externalId}");
      print('OneSignal user changed: $userState');
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      var data = event.notification.additionalData;
      Print("Additional Data is ${event.notification.additionalData}");

      if (data != null) {

          var type = data['type'];
          _handleNotificationBody(type);

      } else {
        print('No additional data found');
      }


      Print(event.result.url);
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      Print(event);
      Print("NOTIFICATION WILL DISPLAY LISTENER CALLED WITH:");
      BlocProvider.of<ChangeBoolCubit>(MyApp.navigatorKey.currentContext!).changeStatusToTrue();
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
      event.notification.title;
      String _debugLabelString =
          "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      print(_debugLabelString);
      // _handleNotificationBody(event.notification.body!);
      // this.setState(() {
      //   _debugLabelString =
      //       "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });


    // final status = await OneSignal.shared.getDeviceState();
    // final String? osUserID = status?.userId;
    // Print("Device ID ${osUserID.toString()}");
    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    //   //  print(changes.to.userId);
    //   String? userId = changes.to.userId ?? '';
    //   if (userId != '') {
    //     AppSharedPreferences.setDeviceId = userId.toString();
    //   }
    // });
    // AppSharedPreferences.setDeviceId = osUserID!.toString();
    //
    // Print("Device Id From Shared Pref ${AppSharedPreferences.getDeviceId}");
    //
    // // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // await OneSignal.shared.promptUserForPushNotificationPermission(
    //   fallbackToSettings: true,
    // );
    // OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent notification) {
    //   Print("Message received");
    //   BlocProvider.of<ChangeBoolCubit>(MyApp.navigatorKey.currentContext!).changeStatusToTrue();
    // });
    //
    // OneSignal.shared.setNotificationOpenedHandler(
    //     (OSNotificationOpenedResult result) async {
    //   try {
    //     final data = result.notification.additionalData;
    //     SavedNotificationData.notificationData= result.notification.additionalData;
    //     Print("saved data from notification ${SavedNotificationData.notificationData}");
    //
    //     Print("data ${data}");
    //     final payload = data!['Navigate'];
    //     final navigate = payload.toString();
    //
    //     Print("payload ${payload.toString()}");
    //     getNavigationKey(navigate);
    //
    //   } catch (e, stacktrace) {
    //     Print("e $e");
    //   }
    // });
    //
    // /// Calls when the notification opens the app.
    // // OneSignal.shared.setNotificationOpenedHandler(handleBackgroundNotification);
    //
    // await OneSignal.shared
    //     .promptUserForPushNotificationPermission()
    //     .then((accepted) {
    //   Print("Accepted permission: $accepted");
    // });
    // await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
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

  Future<void> getUserNotifications(
      {int limit = 8, bool loadMore = false, bool isRefreshing = false}) async {
    if (isRefreshing) {
      limit = 8;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      Print('offset1 $offset');
      if (count <= offset) {
        Print("Done");
        return;
      }
    } else {
      offset = 0;
      emit(GetNotificationsLoading());
    }
    var response = await NotificationRepository.getUserNotifications(
        offset: offset, limit: limit);
    if (response is NotificationsResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<NotificationModel> notificationsAsList = <NotificationModel>[];
      notificationsAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (notifications.length < count) {
          notifications.addAll(notificationsAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        notifications = notificationsAsList;
      }
      emit(GetNotificationsSuccessfully(
          notifications: List<NotificationModel>.from(notifications),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetNotificationsError(message: response.message));
    } else if (response is Message) {
      emit(GetNotificationsError(message: response.content));
    }
  }
}

void getNavigationKey(String key) {
  print("key $key");
  if (key == "Bookings") {
    MyApp.navigatorKey.currentState?.pushNamed(bookingRoute);
  }
}

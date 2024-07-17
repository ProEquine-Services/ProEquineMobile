part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsSuccessfully extends NotificationsState {
  final List<NotificationModel> notifications;
  final int offset;
  final int count;

  GetNotificationsSuccessfully(
      {required this.notifications, required this.offset, required this.count});
}

class GetNotificationsLoading extends NotificationsState {}

class GetNotificationsError extends NotificationsState {
  final String? message;

  GetNotificationsError({this.message});
}

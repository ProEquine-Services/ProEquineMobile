part of 'event_cubit.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class AllEventsSuccessful extends EventState {
  final List<EventsResponseModel>? events;
  final int? currentPage;
  AllEventsSuccessful({this.events, this.currentPage});
}

class AllEventsLoading extends EventState {}

class AllEventsError extends EventState {
  final String? message;
  AllEventsError({this.message});
}

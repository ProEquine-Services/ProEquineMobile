
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/features/events/data/events_response_model.dart';
import 'package:proequine/features/events/domain/repo/events_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/pagination_model.dart';
import '../../../core/errors/base_error.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());
  int? lastPageForEvents;
  int eventsCurrentPage = 1;
  List<dynamic> events = [];

  Future<void> getAllEvents({
    int perPage = 8,
    bool loadMore = false,
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      eventsCurrentPage = 1;
    }
    if (loadMore) {
      if (eventsCurrentPage != lastPageForEvents) {
        eventsCurrentPage++;
      } else {
        return;
      }
    } else {
      eventsCurrentPage = 1;
      emit(AllEventsLoading());
    }
    var requestData =
        Pagination(pageNumber: eventsCurrentPage, pageSize: perPage);
    var response = await EventsRepository.getALlEvents(requestData);
    if (response is Pagination) {
      lastPageForEvents = response.totalRecords;
      List<dynamic> allEventsAsList = <dynamic>[];
      allEventsAsList = (response.data)!
          .map((event) => EventsResponseModel.fromJson(event))
          .toList();
      if (loadMore) {
        events.addAll(allEventsAsList);
      } else {
        events = allEventsAsList;
      }

      emit(AllEventsSuccessful(
          events: List<EventsResponseModel>.from(events),
          currentPage: response.pageNumber));
    } else if (response is BaseError) {
      if (eventsCurrentPage > 1) eventsCurrentPage--;
      emit(AllEventsError(message: response.message));
    } else if (response is Message) {
      emit(AllEventsError(message: response.content));
    }
  }
}

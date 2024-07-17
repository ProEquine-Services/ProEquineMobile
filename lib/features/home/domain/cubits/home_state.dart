part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllPlacesSuccessfully extends HomeState {
  final List<Place> places;
  final int offset;
  final int count;

  GetAllPlacesSuccessfully(
      {required this.places, required this.offset, required this.count});
}

class GetAllPlacesLoading extends HomeState {}

class GetAllPlacesError extends HomeState {
  final String? message;

  GetAllPlacesError({this.message});
}

class GetUserPlacesSuccessfully extends HomeState {
  final List<UserPlace> places;
  final int offset;
  final int count;

  GetUserPlacesSuccessfully(
      {required this.places, required this.offset, required this.count});
}

class GetUserPlacesLoading extends HomeState {}

class GetUserPlacesError extends HomeState {
  final String? message;

  GetUserPlacesError({this.message});
}

class AddNewPlaceSuccessfully extends HomeState {
  final AddNewPlaceResponseModel responseModel;

  AddNewPlaceSuccessfully({
    required this.responseModel,
  });
}

class AddNewPlaceLoading extends HomeState {}

class AddNewPlaceError extends HomeState {
  final String? message;

  AddNewPlaceError({this.message});
}


class EditPlaceSuccessfully extends HomeState {
  final AddNewPlaceResponseModel responseModel;

  EditPlaceSuccessfully({
    required this.responseModel,
  });
}

class EditPlaceLoading extends HomeState {}

class EditPlaceError extends HomeState {
  final String? message;

  EditPlaceError({this.message});
}

class DeletePlaceSuccessfully extends HomeState {
  final String message;

  DeletePlaceSuccessfully({
    required this.message,
  });
}

class DeletePlaceLoading extends HomeState {}

class DeletePlaceError extends HomeState {
  final String? message;

  DeletePlaceError({this.message});
}

class GetHomeSelectiveServicesSuccessfully extends HomeState {
  final List<SelectiveServiceModel> model;
  final int offset;
  final int count;

  GetHomeSelectiveServicesSuccessfully(
      {required this.model, required this.offset, required this.count});
}

class GetHomeSelectiveServicesLoading extends HomeState {}

class GetHomeSelectiveServicesError extends HomeState {
  final String? message;

  GetHomeSelectiveServicesError({this.message});
}

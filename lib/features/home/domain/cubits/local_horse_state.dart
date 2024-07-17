part of 'local_horse_cubit.dart';

@immutable
abstract class LocalHorseState {}

class LocalHorseInitial extends LocalHorseState {}

class CreateTripSuccessfully extends LocalHorseState {
  final Trip item;

  CreateTripSuccessfully({required this.item});
}

class CreateTripLoading extends LocalHorseState {}

class CreateTripError extends LocalHorseState {
  final String? message;

  CreateTripError({required this.message});
}

class DeleteTripSuccessfully extends LocalHorseState {
  final Trip item;

  DeleteTripSuccessfully({required this.item});
}

class DeleteTripLoading extends LocalHorseState {}

class DeleteTripError extends LocalHorseState {
  final String? message;

  DeleteTripError({required this.message});
}
class GetTripsSuccessfully extends LocalHorseState {
  final List<Trip> items;

  GetTripsSuccessfully({required this.items});
}

class GetTripsLoading extends LocalHorseState {}

class GetTripsError extends LocalHorseState {
  final String? message;

  GetTripsError({required this.message});
}

class GetHorsesSuccessfully extends LocalHorseState {
  final List<Horse> items;
  final String tripId;

  GetHorsesSuccessfully({required this.items,required this.tripId});
}

class GetHorsesLoading extends LocalHorseState {}

class GetHorsesError extends LocalHorseState {
  final String? message;

  GetHorsesError({required this.message});
}

class AddHorsesSuccessfully extends LocalHorseState {
  final List<Trip> items;

  AddHorsesSuccessfully({required this.items});
}

class AddHorsesLoading extends LocalHorseState {}

class AddHorsesError extends LocalHorseState {
  final String? message;

  AddHorsesError({required this.message});
}

class GetTripSuccessfully extends LocalHorseState {
  final Trip trip;
  final String tripId;

  GetTripSuccessfully({required this.trip,required this.tripId});
}

class GetTripLoading extends LocalHorseState {}

class GetTripError extends LocalHorseState {
  final String? message;

  GetTripError({required this.message});
}
class EditHorseDetailsSuccessfully extends LocalHorseState {
  final String message;

  EditHorseDetailsSuccessfully({required this.message});
}

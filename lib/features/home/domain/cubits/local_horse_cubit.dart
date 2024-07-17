import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:proequine/features/home/data/local_trip.dart';

import '../../../../core/utils/Printer.dart';
import '../repo/local_storage_repository.dart';

part 'local_horse_state.dart';

class LocalHorseCubit extends Cubit<LocalHorseState> {
  final LocalStorageRepository _localStorageRepository;

  LocalHorseCubit({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(LocalHorseInitial());

  bool isAdded = false;
  List<int> wishListIds = [];
  List<Trip> trips = [];
  List<Horse> horses = [];

  Future<void> createTrip(CreateTripSuccessfully event) async {
    emit(CreateTripLoading());
    try {
      Print(trips.length);
      Print('first print$trips');
      Box box = await _localStorageRepository.openBox();

      // wishListIds.add(event.item.id!);

      _localStorageRepository.createTrip(box, event.item);
      // _localStorageRepository.addAuctionIds(event.item.id);

      Print(trips.length);
      Print(trips);

      await getAllTrips();
      // Print(ids.values);
      emit(CreateTripSuccessfully(item: event.item));
    } catch (_) {
      emit(CreateTripError(message: "error"));
    }
  }

  Future<void> deleteTrip(DeleteTripSuccessfully event) async {
    // await Future<void>.delayed(const Duration(seconds: 3));
    emit(DeleteTripLoading());
    try {
      Box box = await _localStorageRepository.openBox();

      _localStorageRepository.deleteTrip(box, event.item);

      await getAllTrips();

      emit(DeleteTripSuccessfully(item: event.item));
    } catch (_) {
      emit(DeleteTripError(message: "error"));
    }
  }

  Future<void> getAllTrips() async {
    emit(GetTripsLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Trip> items = _localStorageRepository.getAllTrips(box);
      trips = items;
      // await Future<void>.delayed(const Duration(seconds: 1));
      Print(trips.length);
      emit(GetTripsSuccessfully(items: items));
    } catch (_, error) {
      Print(error);
      emit(GetTripsError(message: "error"));
    }
  }

  Future<void> getAllHorses(String tripId) async {
    emit(GetHorsesLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Horse> items = _localStorageRepository.getHorses(tripId);
      horses = items;
      // await Future<void>.delayed(const Duration(seconds: 1));
      Print(horses.length);
      emit(GetHorsesSuccessfully(items: items, tripId: tripId));
    } catch (_, error) {
      Print(_);

      Print(error);
      emit(GetHorsesError(message: "error"));
    }
  }

  Future<void> getTrip(String tripId) async {
    emit(GetTripLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      Trip? trip = await _localStorageRepository.getSpecificTrip(tripId);
      // await Future<void>.delayed(const Duration(seconds: 1));
      Print(horses.length);
      emit(GetTripSuccessfully(trip: trip!, tripId: tripId));
    } catch (_, error) {
      Print(_);

      Print(error);
      emit(GetTripError(message: "error"));
    }
  }
}

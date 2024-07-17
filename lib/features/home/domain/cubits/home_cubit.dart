import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/home/data/edit_place_request_model.dart';
import 'package:proequine/features/home/data/new_place_request_model.dart';
import 'package:proequine/features/home/data/new_place_response_model.dart';
import 'package:proequine/features/home/data/user_places_response_model.dart';
import 'package:proequine/features/home/domain/repo/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/CoreModels/base_response_model.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/utils/Printer.dart';
import '../../../shipping/data/selective_service_response_model.dart';
import '../../data/get_all_places_response_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int? limit = 8;
  List<dynamic> places = [];
  List<dynamic> userPlaces = [];
  List<dynamic> selectiveServices = [];
  int count = 0;
  int userPlacesCount = 0;
  int total = 0;
  int selectiveCount = 0;
  int selectiveOffset = 0;
  int offset = 0;
  int userPlacesOffset = 0;
  late RefreshController refreshController;

  Future<void> getAllPlaces({
    int limit = 8,
    bool loadMore = false,
    String? category,
    bool isRefreshing = false,
    String? fullName,
  }) async {
    if (isRefreshing) {
      limit = 8;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      print('offset1 $offset');
      if (count <= offset) {
        print("Done");
        return;
      }
    } else {
      offset = 0;
      emit(GetAllPlacesLoading());
    }
    var response = await HomeRepository.getAllPlaces(
      offset: offset,
      limit: limit,
      fullName: fullName,
      category: category,
    );
    if (response is AllPlacesResponseModel) {
      print("Offset is $offset");
      count = response.count!;
      List<Place> placesAsList = response.rows!;

      if (loadMore) {
        print("Load More Now");
        if (places.length < count) {
          places.addAll(placesAsList);
          print("Case 1");
        } else {
          print("Case 2");
          return;
        }
      } else {
        places = placesAsList;
      }

      // Remove the first item if category is "Airport" or "Hospital"
      if (category == "Airport" || category == "Hospital") {
        if (places.isNotEmpty) {
          places.removeAt(0);
        }
      }

      emit(GetAllPlacesSuccessfully(
        places: List<Place>.from(places),
        offset: offset,
        count: count,
      ));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllPlacesError(message: response.message));
    } else if (response is Message) {
      emit(GetAllPlacesError(message: response.content));
    }
  }


  Future<void> getUserPlaces({
    int limit = 8,
    bool loadMore = false,
    String? category,
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      limit = 8;
      userPlacesOffset = 0;
    }
    if (loadMore) {
      userPlacesOffset = limit + userPlacesOffset;
      print('offset1 $userPlacesOffset');
      if (userPlacesCount <= userPlacesOffset) {
        print("Done");
        return;
      }
    } else {
      userPlacesOffset = 0;
      emit(GetUserPlacesLoading());
    }
    var response = await HomeRepository.getUserPlaces(
      offset: userPlacesOffset,
      limit: limit,
    );
    if (response is UserPlacesResponseModel) {
      print("Offset is $userPlacesOffset");
      userPlacesCount = response.count!;
      List<UserPlace> placesAsList = response.rows!;

      if (loadMore) {
        print("Load More Now");
        if (userPlaces.length < userPlacesCount) {
          userPlaces.addAll(placesAsList);
          print("Case 1");
        } else {
          print("Case 2");
          return;
        }
      } else {
        userPlaces = placesAsList;
      }



      emit(GetUserPlacesSuccessfully(
        places: List<UserPlace>.from(userPlaces),
        offset: userPlacesOffset,
        count: userPlacesCount,
      ));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetUserPlacesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserPlacesError(message: response.content));
    }
  }




  Future<void> addNewPlace(
      AddNewPlaceRequestModel addNewPlaceRequestModel) async {
    emit(AddNewPlaceLoading());
    var response = await HomeRepository.addNewPlace(addNewPlaceRequestModel);
    if (response is AddNewPlaceResponseModel) {
      emit(AddNewPlaceSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddNewPlaceError(message: response.message));
    } else if (response is Message) {
      emit(AddNewPlaceError(message: response.content));
    }
  }


  Future<void> editPlace(
      EditPlaceRequestModel editPlaceRequestModel) async {
    emit(EditPlaceLoading());
    var response = await HomeRepository.editPlace(editPlaceRequestModel);
    if (response is AddNewPlaceResponseModel) {
      emit(EditPlaceSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(EditPlaceError(message: response.message));
    } else if (response is Message) {
      emit(EditPlaceError(message: response.content));
    }
  }

  Future<void> deletePlace(
      int id) async {
    emit(DeletePlaceLoading());
    var response = await HomeRepository.deletePlace(id);
    if (response is EmptyModel) {
      emit(DeletePlaceSuccessfully(message: 'Place is deleted successfully.'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(DeletePlaceError(message: response.message));
    } else if (response is Message) {
      emit(DeletePlaceError(message: response.content));
    }
  }

  Future<void> getAllSelectiveServices(
      {int limit = 8,
        bool loadMore = false,
        bool showOnHomePage = true,
        String type = 'Import',
        bool isRefreshing = false}) async {
    if (isRefreshing) {
      limit = 8;
      selectiveOffset = 0;
    }
    if (loadMore) {
      selectiveOffset = limit + selectiveOffset;
      Print('offset1 $selectiveOffset');
      if (selectiveCount <= selectiveOffset) {
        Print("Done");
        return;
      }
    } else {
      selectiveOffset = 0;
      emit(GetHomeSelectiveServicesLoading());
    }
    var response = await HomeRepository.getHomeSelectiveService(
        offset: selectiveOffset, limit: limit, type: type,showOnHomePage: showOnHomePage);
    if (response is SelectiveServiceResponseModel) {
      Print("Offset is $selectiveOffset");
      selectiveCount = response.count!;
      List<SelectiveServiceModel> selectiveAsList = <SelectiveServiceModel>[];
      selectiveAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (selectiveServices.length < selectiveCount) {
          selectiveServices.addAll(selectiveAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        selectiveServices = selectiveAsList;
      }
      emit(GetHomeSelectiveServicesSuccessfully(
          model: List<SelectiveServiceModel>.from(selectiveServices),
          offset: selectiveOffset,
          count: selectiveCount));
    } else if (response is BaseError) {
      if (selectiveOffset > 0) selectiveOffset = 0;
      emit(GetHomeSelectiveServicesError(message: response.message));
    } else if (response is Message) {
      emit(GetHomeSelectiveServicesError(message: response.content));
    }
  }

}


import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/home/data/edit_place_request_model.dart';
import 'package:proequine/features/home/data/get_all_places_response_model.dart';
import 'package:proequine/features/home/data/new_place_request_model.dart';
import 'package:proequine/features/home/data/new_place_response_model.dart';
import 'package:proequine/features/home/data/user_places_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../shipping/data/selective_service_response_model.dart';

class HomeRepository {
  static Future<BaseResultModel?> addNewPlace(
      AddNewPlaceRequestModel addNewPlaceRequestModel) async {
    return await RemoteDataSource.request<AddNewPlaceResponseModel>(
        converter: (json) => AddNewPlaceResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: addNewPlaceRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addNewPlace);
  }

  static Future<BaseResultModel?> editPlace(
      EditPlaceRequestModel editPlaceRequestModel) async {
    return await RemoteDataSource.request<AddNewPlaceResponseModel>(
        converter: (json) => AddNewPlaceResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: editPlaceRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addNewPlace);
  }


  static Future<BaseResultModel?> deletePlace(
      int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.addNewPlace}$id');
  }

  static Future<BaseResultModel?> getAllPlaces(
      {required int offset,
      required int limit,
      String? fullName,
      String? category}) async {
    return await RemoteDataSource.request<AllPlacesResponseModel>(
        converter: (json) => AllPlacesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
          "category": category,
          "searchValue": fullName,
        },
        thereDeviceId: false,
        url: ApiURLs.getAllPlaces);
  }

  static Future<BaseResultModel?> getUserPlaces({
    required int offset,
    required int limit,
  }) async {
    return await RemoteDataSource.request<UserPlacesResponseModel>(
        converter: (json) => UserPlacesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
        },
        thereDeviceId: false,
        url: ApiURLs.getUserPlaces);
  }

  static Future<BaseResultModel?> getHomeSelectiveService(
      {required int offset,
      required int limit,
      String? type,
      required bool showOnHomePage}) async {
    return await RemoteDataSource.request<SelectiveServiceResponseModel>(
        converter: (json) => SelectiveServiceResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.forceCache,
        refreshDuration: const Duration(hours: 1),
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
          "type": type,
          "showOnHomePage": showOnHomePage,
        },
        thereDeviceId: false,
        url: ApiURLs.getSelectiveService);
  }
}

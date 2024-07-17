import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/shipping/data/create_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/create_shipping_response_model.dart';
import 'package:proequine/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/join_selective_service_request_model.dart';
import 'package:proequine/features/shipping/data/selective_service_response_model.dart';
import 'package:proequine/features/shipping/data/shipping_response_model.dart';
import 'package:proequine/features/shipping/data/user_shipping_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class ShippingRepository {
  static Future<BaseResultModel?> createShippingRequest(
      CreateShippingRequestModel createShippingRequestModel) async {
    return await RemoteDataSource.request<CreateShippingResponseModel>(
        converter: (json) => CreateShippingResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: createShippingRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.createShipping);
  }

  static Future<BaseResultModel?> editShippingRequest(
      EditShippingRequestModel editShippingRequestModel) async {
    return await RemoteDataSource.request<CreateShippingResponseModel>(
        converter: (json) => CreateShippingResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: editShippingRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.createShipping);
  }

  static Future<BaseResultModel?> pushShippingRequest(
      int id) async {
    return await RemoteDataSource.request<ShippingResponseModel>(
        converter: (json) => ShippingResponseModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: {
          "id":id
        },
        thereDeviceId: false,
        url: ApiURLs.pushShipping);
  }

  static Future<BaseResultModel?> joinSelectiveService(JoinSelectiveServiceRequestModel joinSelectiveServiceRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: joinSelectiveServiceRequestModel.toJson(),
        thereDeviceId: false,
        url: ApiURLs.joinSelectiveService);
  }
  static Future<BaseResultModel?> getShippingDetails(
      int id) async {
    return await RemoteDataSource.request<ShippingResponseModel>(
        converter: (json) => ShippingResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.createShipping}$id');
  }

  static Future<BaseResultModel?> removeShipping(
      int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.createShipping}$id');
  }
  // static Future<BaseResultModel?> pushTransport(
  //     int id) async {
  //   return await RemoteDataSource.request<TransportModel>(
  //       converter: (json) => TransportModel.fromJson(json),
  //       method: HttpMethod.POST,
  //       data: {
  //         "id":id
  //       },
  //       withAuthentication: true,
  //       thereDeviceId: false,
  //       url: ApiURLs.pushTransport);
  // }

  static Future<BaseResultModel?> getAllShippingRequests(
      {required int offset, required int limit, String? status}) async {
    return await RemoteDataSource.request<GetUserShippingResponseModel>(
        converter: (json) => GetUserShippingResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
          "status": status,
        },
        thereDeviceId: false,
        url: ApiURLs.getShippingRequest);
  }
  static Future<BaseResultModel?> getSelectiveService(
      {required int offset, required int limit, String? type,required bool showOnHomePage}) async {
    return await RemoteDataSource.request<SelectiveServiceResponseModel>(
        converter: (json) => SelectiveServiceResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // policy: CachePolicy.refresh,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
          "type": type,
        },
        thereDeviceId: false,
        url: ApiURLs.getSelectiveService);
  }
}

import 'package:proequine_dev/features/transports/data/create_transport_request_model.dart';
import 'package:proequine_dev/features/transports/data/update_local_transport_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../transports/data/get_all_transports_response_model.dart';
import '../../data/create_transport_response_model.dart';

class TransportRepository {
  static Future<BaseResultModel?> createLocalTransport(
      CreateTransportRequestModel createTransportRequestModel) async {
    return await RemoteDataSource.request<TransportModel>(
        converter: (json) => TransportModel.fromJson(json),
        method: HttpMethod.POST,
        data: createTransportRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.createTransport);
  }

  static Future<BaseResultModel?> updateTransport(
      UpdateTransportRequestModel updateTransportRequestModel) async {
    return await RemoteDataSource.request<TransportModel>(
        converter: (json) => TransportModel.fromJson(json),
        method: HttpMethod.POST,
        data: updateTransportRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.createTransport);
  }
  static Future<BaseResultModel?> pushTransport(
      int id) async {
    return await RemoteDataSource.request<TransportModel>(
        converter: (json) => TransportModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "id":id
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.pushTransport);
  }

  static Future<BaseResultModel?> getAllTransports(
      {required int offset, required int limit, String? status}) async {
    return await RemoteDataSource.request<GetUserTransportsResponseModel>(
        converter: (json) => GetUserTransportsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,
          "status": status,
        },
        thereDeviceId: false,
        url: ApiURLs.getTransports);
  }

  static Future<BaseResultModel?> removeTrip(
      int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.createTransport}/$id');
  }
}

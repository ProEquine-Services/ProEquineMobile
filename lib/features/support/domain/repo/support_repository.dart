import 'package:proequine/features/support/data/create_support_response_model.dart';
import 'package:proequine/features/support/data/get_all_support_request_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/support_request_model.dart';

class SupportRepository{
  static Future<BaseResultModel?> contactSupport(
      CreateSupportRequestModel supportRequestModel) async {
    return await RemoteDataSource.request<CreateSupportResponseModel>(
        converter: (json) => CreateSupportResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: supportRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.contactSupport);
  }
  static Future<BaseResultModel?> getAllRequests({required int limit,required int offset}) async {
    return await RemoteDataSource.request<GetAllSupportRequestResponseModel>(
        converter: (json) => GetAllSupportRequestResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getAllRequests);
  }
}
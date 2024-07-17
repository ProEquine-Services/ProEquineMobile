import 'package:proequine/features/stables/data/chose_stable_response_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/chose_stable_request_model.dart';
import '../../data/get_stables_response_model.dart';

class StableRepository{

  static Future<BaseResultModel?> choseStable(
      ChoseMainStableRequestModel choseStableRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: choseStableRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.choseStables);
  }

  static Future<BaseResultModel?> getAllStables(
      {required int offset, required int limit,String? fullName}) async {
    return await RemoteDataSource.request<AllStablesResponseModel>(
        converter: (json) => AllStablesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset":offset,
          "limit":limit,
          "name":fullName,
        },
        thereDeviceId: false,
        url: ApiURLs.getStables);
  }
}
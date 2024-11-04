import 'package:proequine_dev/core/CoreModels/empty_model.dart';
import 'package:proequine_dev/features/uncompleted_customers/data/update_exist_account_request_model.dart';
import 'package:proequine_dev/features/user/data/login_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class ExistCustomerRepository {
  static Future<BaseResultModel?> updateExistCustomerDetails(
      UpdateExistAccountRequestModel updateAccountDetails) async {
    return await RemoteDataSource.request<LoginResponseModel>(
        converter: (json) => LoginResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: updateAccountDetails.toJson(),
        withAuthentication: true,
        thereDeviceId: true,
        url: ApiURLs.updateCustomerDetails);
  }

  static Future<BaseResultModel?> sendCredentials(
      int userId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "userId":userId
        },
        withAuthentication: false,
        thereDeviceId: true,
        url: ApiURLs.sendCredentials);
  }
}
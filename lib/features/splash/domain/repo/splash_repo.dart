import 'package:proequine/features/splash/data/env_response_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class SplashRepository {
  static Future<BaseResultModel?> refreshToken(
      String refreshToken) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "refreshToken":refreshToken,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getNewToken);
  }

  static Future<BaseResultModel?> getTheEnvironment(String buildNumber) async {
    return await RemoteDataSource.request<EnvResponseModel>(
        converter: (json) => EnvResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          "buildNumber": buildNumber,
        },
        withAuthentication: false,
        thereDeviceId: false,
        url:
            "https://pet-webapi-uaeno-dev-001.azurewebsites.net/api/User/getbuildnumber");
  }

// static Future<BaseResultModel?> versionModel() async {
//   return await RemoteDataSource.request<VersionResponseModel>(
//       converter: (json) => VersionResponseModel.fromJson(json),
//       method: HttpMethod.GET,
//       withAuthentication: true,
//       url: ApiURLs.forceUpdate);
// }
}

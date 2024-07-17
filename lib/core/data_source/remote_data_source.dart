import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import '../CoreModels/base_result_model.dart';
import '../constants/constants.dart';
import '../http/api_provider.dart';
import '../utils/printer.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class RemoteDataSource {
  static Future<BaseResultModel?> request<Response extends BaseResultModel>(
      {required Response Function(Map<String, dynamic> json) converter,
        required String method,
        required String url,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? data,
        Map<String, String>? files,
        CachePolicy policy=CachePolicy.request,
        Duration refreshDuration=const Duration(days: 1 ),
        bool withAuthentication = true,
        bool thereDeviceId = true,
        CancelToken? cancelToken,
        bool isLongTime = false}) async {
    assert(converter != null);
    assert(method != null);
    assert(url != null);

    Map<String, String> headers = {
      HEADER_CONTENT_TYPE: "application/json",
      HEADER_ACCEPT: "application/json",

    };

    /// Get the language.
    String lang = 'en';
    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);


    if (withAuthentication) {
      final token = await SecureStorage().getToken();
      if (token != null || token != '' ) {
        headers.putIfAbsent(HEADER_AUTH, () => ('bearer $token'));
      }
    }

    if (thereDeviceId) {
      final deviceId=AppSharedPreferences.getDeviceId;
      if (deviceId != null || deviceId!='') {
          headers.putIfAbsent(DEVICE_ID, () => (deviceId.toString()));
      } else {
      }


    }
    //ToDo remove prints
    Print.inf('HEADERS  $headers');

    Print.inf('--------------------  Start Request Body  --------------------'
        ' \n The HttpMethod & URL are : [$method: $url]');
    Print.inf('The sended Object Request is : $data');
    Print.inf('The headers is : $headers');
    Print.inf('The queryParameters is : $queryParameters \n '
        '--------------------  End Request Body  --------------------'
        ' \n');

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      converter: converter,
      headers: headers,
      policy: policy,
      refreshDuration: refreshDuration,
      queryParameters: queryParameters ?? {},
      data: data ?? {},
      files: files,
      isLongTime: isLongTime,
      cancelToken: cancelToken,
    );

    if (response.success!) {
      return response.data;
    } else {
      if (response.message != null) {
        return response.message;
      }
    }
    return null;
  }
}

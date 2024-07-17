import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:proequine/core/http/path_provider.dart';

import '../CoreModels/base_response_model.dart';
import '../CoreModels/base_result_model.dart';
import '../constants/constants.dart';
import '../errors/HttpMethodUnCorrect.dart';
import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';
import '../utils/Printer.dart';

class ApiProvider {
  static Future<BaseResponseModel> sendObjectRequest<T extends BaseResultModel>(
      {required T Function(Map<String, dynamic>) converter,
      required String method,
      required String url,
      Map<String, dynamic>? data,
      CachePolicy policy = CachePolicy.refreshForceCache,
      Duration refreshDuration = const Duration(minutes:1 ),
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? files,
      CancelToken? cancelToken,
      bool isLongTime = false}) async {
    /// Edited Here
    var baseOptions = BaseOptions(
      connectTimeout: isLongTime ? const Duration(milliseconds: 30 * 1000) : const Duration(milliseconds: 15 * 1000),
    );
    var dio = Dio();

    var cacheStore = HiveCacheStore(AppPathProvider.path);
    var cacheInterceptor = DioCacheInterceptor(
      options: CacheOptions(
        store: cacheStore,

        policy: policy,
        hitCacheOnErrorExcept: [401, 403, 302],
        maxStale: refreshDuration,
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: true,
      ),
    );

    dio.interceptors.add(cacheInterceptor);

    Options options = Options(
      headers: headers,
      method: method,
      contentType: Headers.jsonContentType,
      receiveTimeout: const Duration(milliseconds:60 * 1000 ),
      // 60 seconds
      sendTimeout: const Duration(milliseconds:60 * 1000 ),
    );

    if (files != null) {
      headers?.remove(HEADER_CONTENT_TYPE);

      ///Edited
      data ??= {};

      await Future.forEach(files.entries, (MapEntry entry) async {
        if (entry.value != null || entry.key != null) {
          data?.addAll({entry.key: await MultipartFile.fromFile(entry.value)});
        }
      });
    }

    try {
      Response response;
      response = await dio.request(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          data: files != null ? FormData.fromMap(data!) : data);
      // Get the decoded json
      if (response.extra['isCached'] == true) {
        print('Data is coming from cache');
      } else {
        print('Data is coming from server');
      }

      var decodedJson;

      if (response.data is String) {
        if (response.data.length == 0) {
          decodedJson = {"": ""};
        } else {
          decodedJson = json.decode(response.data);
        }
      } else {
        decodedJson = response.data;
      }

      Print(decodedJson);
      if (response.extra.containsKey('dio_cache_source') &&
          response.extra['dio_cache_source'] == 'CACHE') {
        Print('Data retrieved from cache');
      } else {
        Print('Data retrieved from the network');
      }

      return BaseResponseModel.fromJson(json: decodedJson, fromJson: converter);
    }

    // Handling errors
    on DioException catch (e, s) {
      Print('catch DioError ');
      Print(e);

      Print('Stacktrace DioError ');
      Print(s);
      var error = _handleDioError(e);
      var json;
      Print('DioErrorDioErrorDioError $error');
      if (e.response != null) if (e.response?.data !=
          null) if (!(e.response?.data is String)) {
        Print(e.response?.data);
        json = e.response?.data;
      }

      return BaseResponseModel.fromJson(json: json, error: error);
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      Print(e);
      Print(stacktrace);
      return BaseResponseModel.fromJson(error: SocketError());
    } catch (e, stacktrace) {
      Print(e);
      Print(stacktrace);
      return BaseResponseModel.fromJson(error: SocketError());
    }
  }

  static BaseError _handleDioError(DioException error) {
    Print('error.type = ${(error.type)}');
    if (error.type == DioExceptionType.badResponse ||
        error.type == DioExceptionType.connectionError) {
      if (error is SocketException) return SocketError();
      if (error.type == DioExceptionType.badResponse) {
        switch (error.response?.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 405:
            return HttpMethodUnCorrect();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioExceptionType.cancel) {
      return CancelError();
    } else {
      return UnknownError();
    }
  }
}

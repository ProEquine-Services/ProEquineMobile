import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor extends DioCacheInterceptor {
  CacheInterceptor({required CacheOptions options}) : super(options: options);
}
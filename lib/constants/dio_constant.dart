import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/providers/filter_sensor_provider.dart';

final dioProviderConstant = Provider((ref) {
  final dio = Dio();

  dio.options.responseType = ResponseType.json;
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  // Tambahkan timeout
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  // Tambahkan interceptor untuk logging
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
      logger.d('REQUEST DATA: ${options.data}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      logger.d(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      logger.e(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      return handler.next(e);
    },
  ));

  return dio;
});

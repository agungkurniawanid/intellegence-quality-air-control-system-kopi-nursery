import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/models/model_monicontrollings.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final logger = Logger();

final dioProvider = Provider((ref) {
  final dio = Dio();
  dio.options.responseType =
      ResponseType.json; // Mengatur response type ke JSON
  return dio;
});

final sensorDataApiProvider =
    StreamProvider.family<Monicontrolling, int>((ref, id) async* {
  final dio = ref.watch(dioProvider); // Menggunakan dio dari provider

  // Mengambil token dari SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) {
    throw Exception('Token tidak ditemukan');
  }

  try {
    await for (final _ in Stream.periodic(const Duration(seconds: 2))) {
      final response = await dio.get(
        '${ApiConstants.getDataTempHumidityEndpoint}$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      logger.d('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          yield Monicontrolling.fromJson(
              response.data); // Menyebarkan data setiap kali diperbarui
        } else {
          throw const FormatException('Unexpected response format');
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load sensor data: ${response.statusCode}',
        );
      }
    }
  } catch (e) {
    logger.e('Error occurred: $e');
    throw Exception('Unexpected error: $e');
  }
});

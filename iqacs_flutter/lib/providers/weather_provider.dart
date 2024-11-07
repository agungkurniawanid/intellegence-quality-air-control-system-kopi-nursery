import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:iqacs/models/model_weather.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final logger = Logger();

final dioProvider = Provider((ref) {
  final dio = Dio();
  dio.options.responseType = ResponseType.json;
  return dio;
});

final weatherProvider =
    StreamProvider.family<WeatherModel, String>((ref, city) async* {
  final dio = ref.watch(dioProvider);

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) {
    throw Exception('Token tidak ditemukan');
  }
  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=89c748adb995fb8bc8afbe287c41ed51&units=metric',
  );

  try {
    await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
      final response = await dio.get(
        url.toString(),
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
          yield WeatherModel.fromJson(response.data);
        } else {
          throw const FormatException('Unexpected response format');
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load weather data: ${response.statusCode}',
        );
      }
    }
  } catch (e) {
    logger.e('Error occurred: $e');
    throw Exception('Unexpected error: $e');
  }
});

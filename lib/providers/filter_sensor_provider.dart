import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/models/model_alat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

final sensorDataProvider = StateProvider<List<String>>((ref) {
  return ["Alat 1", "Alat 2", "Alat 3", "Alat 4"];
});

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final switchStateProvider = StateProvider<bool>((ref) => false);

final pumpApiProvider = Provider((ref) => PumpApiService(ref));

final logger = Logger();

final dioProvider = Provider((ref) {
  final dio = Dio();
  dio.options.responseType = ResponseType.json;
  return dio;
});

class PumpApiService {
  final Ref ref;
  PumpApiService(this.ref);

  Future<void> togglePump() async {
    final dio = ref.read(dioProvider);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await dio.post(
        ApiConstants.pompaToggleEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      logger.d('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = StatusResponse.fromJson(response.data);
        ref.read(switchStateProvider.notifier).state = data.pompaStatus;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to toggle pump: ${response.statusCode}',
        );
      }
    } catch (e) {
      logger.e('Error occurred: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}

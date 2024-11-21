import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/res/res_model_pengguna.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getDataPenggunaProvider = FutureProvider<ResModelPengguna>((ref) async {
  final dio = ref.watch(dioProviderConstant);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final userId = prefs.getString('id_pengguna');

  logger.d('Token: $token');
  logger.d('User  ID: $userId');

  if (userId == null) {
    return ResModelPengguna(
      status: 'error',
      message: 'User  ID not found in Shared Preferences',
    );
  }

  final url = '${ApiConstants.getDataPenggunaEndpoint}$userId';
  logger.d('Request URL: $url');

  try {
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
        validateStatus: (status) {
          return status != null &&
              (status >= 200 && status < 300 || status == 302);
        },
      ),
    );

    logger.d('Response status: ${response.statusCode}');
    logger.d('Response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 302) {
      logger.d('Response data: ${response.data}');
      return ResModelPengguna.fromJson(response.data);
    }

    return ResModelPengguna(
      status: 'error',
      message: 'Gagal memproses permintaan: ${response.statusCode}',
    );
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    return ResModelPengguna(
      status: 'error',
      message: e.response?.data['message'] ??
          e.message ??
          'Terjadi kesalahan jaringan',
    );
  } catch (e) {
    logger.e('Unexpected error occurred: $e');
    return ResModelPengguna(
      status: 'error',
      message: 'Terjadi kesalahan tidak terduga: $e',
    );
  }
});

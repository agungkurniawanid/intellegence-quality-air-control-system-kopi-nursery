import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_update_profile.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final updateProfileProvider =
    FutureProvider.family<UpdateProfile, XFile?>((ref, imageFile) async {
  final dio = ref.watch(dioProviderConstant);

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final idPengguna = prefs.getString('id_pengguna');
  if (imageFile == null) {
    throw ArgumentError('Foto belum dipilih');
  }

  try {
    final response = await dio.post(
      '${ApiConstants.updateFotoEndpoint}$idPengguna',
      data: FormData.fromMap({
        'foto': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_picture_$idPengguna.jpg',
        ),
      }),
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
      if (response.data is Map<String, dynamic>) {
        return UpdateProfile.fromJson(response.data);
      } else if (response.data is String) {
        return UpdateProfile(status: 'error', message: response.data);
      } else {
        return UpdateProfile(
            status: 'error', message: 'Format respons tidak dikenal');
      }
    }
    return UpdateProfile(
        status: 'error',
        message: 'Gagal memproses permintaan: ${response.statusCode}');
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    if (e.response != null) {
      if (e.response!.data is Map<String, dynamic>) {
        return UpdateProfile.fromJson(e.response!.data);
      } else {
        return UpdateProfile(
            status: 'error',
            message: e.message ?? 'Terjadi kesalahan tidak dikenal');
      }
    }
    return UpdateProfile(
        status: 'error', message: e.message ?? 'Terjadi kesalahan jaringan');
  } catch (e) {
    logger.e('Unexpected error occurred: $e');
    return UpdateProfile(
        status: 'error', message: 'Terjadi kesalahan tidak terduga: $e');
  }
});

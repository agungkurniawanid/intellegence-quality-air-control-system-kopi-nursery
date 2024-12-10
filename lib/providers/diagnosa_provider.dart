import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_data_predict.dart';
import 'package:iqacs/models/model_diagnosa.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final predictProvider =
    FutureProvider.family<Diagnosa, XFile?>((ref, imageFile) async {
  final dio = ref.watch(dioProviderConstant);

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final idPengguna = prefs.getString('id_pengguna');

  if (imageFile == null) {
    return Diagnosa(success: false, message: 'Foto belum dipilih');
  }

  try {
    final response = await dio.post(
      '${ApiConstants.predictEndpoint}$idPengguna',
      data: FormData.fromMap({
        'image': await MultipartFile.fromFile(
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

    // Pastikan response.data adalah Map
    if (response.data is Map<String, dynamic>) {
      // Cek apakah kunci 'success' ada di response
      if (response.data.containsKey('success')) {
        return Diagnosa.fromJson(response.data);
      } else {
        // Jika tidak ada kunci 'success', kembalikan diagnosa dengan status error
        return Diagnosa(success: false, message: 'Format respons tidak sesuai');
      }
    } else {
      // Jika bukan Map, kembalikan diagnosa error
      return Diagnosa(success: false, message: 'Format respons tidak dikenal');
    }
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    logger.e('Response data: ${e.response?.data}');
    logger.e('Response status: ${e.response?.statusCode}');

    if (e.response != null && e.response?.data is Map<String, dynamic>) {
      // Coba parsing error response
      try {
        return Diagnosa.fromJson(e.response!.data);
      } catch (_) {
        return Diagnosa(
            success: false,
            message: e.message ?? 'Terjadi kesalahan tidak dikenal');
      }
    }

    return Diagnosa(
        success: false, message: e.message ?? 'Terjadi kesalahan jaringan');
  } catch (e) {
    logger.e('Unexpected error occurred: $e');
    return Diagnosa(
        success: false, message: 'Terjadi kesalahan tidak terduga: $e');
  }
});

final getResultDataDiagnosaProvider = FutureProvider<dynamic>((ref) async {
  final dio = ref.watch(dioProviderConstant);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  logger.d('Token: $token');

  const url = '${ApiConstants.getDataPredict}/terbaru';
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
      return SuccessResponsePredict.fromJson(response.data);
    }
    return ErrorResponsePredict(
      status: 'error',
      message: 'Gagal memproses permintaan: ${response.statusCode}',
    );
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    return ErrorResponsePredict(
      status: 'error',
      message: e.response?.data['message'] ??
          e.message ??
          'Terjadi kesalahan jaringan',
    );
  } catch (e) {
    logger.e('Unexpected error occurred: $e');
    return ErrorResponsePredict(
      status: 'error',
      message: 'Terjadi kesalahan tidak terduga: $e',
    );
  }
});

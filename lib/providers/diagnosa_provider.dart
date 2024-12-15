import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_data_predict.dart';
import 'package:iqacs/models/model_diagnosa.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loaderDiagnosa = StateProvider<bool>((ref) => false);

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

    if (response.data is Map<String, dynamic>) {
      if (response.data.containsKey('success')) {
        return Diagnosa.fromJson(response.data);
      } else {
        return Diagnosa(success: false, message: 'Format respons tidak sesuai');
      }
    } else {
      return Diagnosa(success: false, message: 'Format respons tidak dikenal');
    }
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    logger.e('Response data: ${e.response?.data}');
    logger.e('Response status: ${e.response?.statusCode}');

    if (e.response != null && e.response?.data is Map<String, dynamic>) {
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

final getResultDataDiagnosaProvider =
    FutureProvider.family<dynamic, String>((ref, type) async {
  final dio = ref.watch(dioProviderConstant);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  logger.d('Token: $token');

  String url;
  switch (type) {
    case 'terbaru':
      url = '${ApiConstants.getDataPredict}/terbaru';
      break;
    case 'recent':
      url = '${ApiConstants.getDataPredict}/recent';
      break;
    case 'sejamlalu':
      url = '${ApiConstants.getDataPredict}/sejamlalu';
      break;
    case 'semua':
      url = '${ApiConstants.getDataPredict}/semua';
      break;
    case 'miner':
      url = '${ApiConstants.getDataPredict}/miner';
      break;
    case 'phoma':
      url = '${ApiConstants.getDataPredict}/phoma';
      break;
    case 'health':
      url = '${ApiConstants.getDataPredict}/nodisease';
      break;
    case 'rust':
      url = '${ApiConstants.getDataPredict}/rust';
      break;
    default:
      url = '${ApiConstants.getDataPredict}/terbaru';
  }

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
      if (type == 'terbaru') {
        return SuccessResponsePredict.fromJson(response.data);
      } else {
        return SuccessListResponsePredict.fromJson(response.data);
      }
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

final getDetailDataDiagnosa =
    FutureProvider.family<dynamic, String>((ref, id) async {
  final dio = ref.watch(dioProviderConstant);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  logger.d('Token: $token');

  final url = "${ApiConstants.getDataPredictDetail}/$id";

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

final deleteDiagnosaProvider = FutureProvider.family<ErrorResponsePredict, int>(
  (ref, idDiagnosa) async {
    final dio = ref.watch(dioProviderConstant);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (idDiagnosa <= 0) {
      return ErrorResponsePredict(
          status: 'error', message: 'ID diagnosa tidak valid');
    }

    try {
      final response = await dio.delete(
        '${ApiConstants.getDataPredict}/$idDiagnosa',
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

      if (response.data is Map<String, dynamic>) {
        if (response.data.containsKey('status') &&
            response.data.containsKey('message')) {
          return ErrorResponsePredict.fromJson(response.data);
        } else {
          return ErrorResponsePredict(
            status: 'error',
            message: 'Format respons tidak sesuai',
          );
        }
      } else {
        return ErrorResponsePredict(
          status: 'error',
          message: 'Format respons tidak dikenal',
        );
      }
    } on DioException catch (e) {
      logger.e('Dio Error occurred: $e');
      logger.e('Response data: ${e.response?.data}');
      logger.e('Response status: ${e.response?.statusCode}');

      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        try {
          return ErrorResponsePredict.fromJson(e.response!.data);
        } catch (_) {
          return ErrorResponsePredict(
            status: 'error',
            message: e.message ?? 'Terjadi kesalahan tidak dikenal',
          );
        }
      }

      return ErrorResponsePredict(
        status: 'error',
        message: e.message ?? 'Terjadi kesalahan jaringan',
      );
    } catch (e) {
      logger.e('Unexpected error occurred: $e');
      return ErrorResponsePredict(
        status: 'error',
        message: 'Terjadi kesalahan tidak terduga: $e',
      );
    }
  },
);

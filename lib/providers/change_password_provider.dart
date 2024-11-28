import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_forgot_password.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordParams {
  final String? oldPassword;
  final String? newPassword;
  final String? confirmPassword;

  ChangePasswordParams(
      {this.oldPassword, this.newPassword, this.confirmPassword});
}

final changePasswordProvider =
    FutureProvider.family<ForgotPassword, ChangePasswordParams>(
        (ref, changePasswordParams) async {
  final dio = ref.watch(dioProviderConstant);
  final preferenses = await SharedPreferences.getInstance();
  final idUser = preferenses.getString('id_users');
  final token = preferenses.getString('access_token');

  try {
    final response = await dio.post(
      '${ApiConstants.changePasswordEndpoint}$idUser',
      data: {
        'old_password': changePasswordParams.oldPassword,
        'new_password': changePasswordParams.newPassword,
        'new_password_confirmation': changePasswordParams.confirmPassword
      },
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
        return ForgotPassword.fromJson(response.data);
      } else if (response.data is String) {
        return ForgotPassword(status: 'error', message: response.data);
      } else {
        return ForgotPassword(
            status: 'error', message: 'Format respons tidak dikenal');
      }
    }
    return ForgotPassword(
        status: 'error',
        message: 'Gagal memproses permintaan: ${response.statusCode}');
  } on DioException catch (e) {
    logger.e('Dio Error occurred: $e');
    if (e.response != null) {
      if (e.response!.data is Map<String, dynamic>) {
        return ForgotPassword.fromJson(e.response!.data);
      } else {
        return ForgotPassword(
            status: 'error',
            message: e.message ?? 'Terjadi kesalahan tidak dikenal');
      }
    }
    return ForgotPassword(
        status: 'error', message: e.message ?? 'Terjadi kesalahan jaringan');
  } catch (e) {
    logger.e('Unexpected error occurred: $e');
    return ForgotPassword(
        status: 'error', message: 'Terjadi kesalahan tidak terduga: $e');
  }
});

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_forgot_password.dart';
import 'package:iqacs/providers/filter_sensor_provider.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<int> {
  Timer? _timer;

  TimerNotifier() : super(120);

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    state = 120;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final checkOtpProvider =
    FutureProvider.family<ForgotPassword, Map<String, String>>(
        (ref, params) async {
  final dio = ref.watch(dioProviderConstant);
  final noTelfon = params['no_telfon'];
  final otp = params['otp'];

  if (noTelfon == null || otp == null) {
    throw ArgumentError('no_telfon dan otp harus disediakan');
  }

  try {
    final response = await dio.post(
      '${ApiConstants.verifikasiOtpEndpoint}$noTelfon',
      data: {'otp': otp},
      options: Options(
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

final resendOtpProvider =
    FutureProvider.family<ForgotPassword, String>((ref, noTelfon) async {
  final dio = ref.watch(dioProviderConstant);

  try {
    final response = await dio.post(
      '${ApiConstants.kirimUlangOtpEndpoint}$noTelfon',
      options: Options(
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

class ParamsResetPassword {
  final String? noTelfon;
  final String? password;
  final String? confirmPassword;

  ParamsResetPassword({this.noTelfon, this.password, this.confirmPassword});
}

final resetPasswordProvider =
    FutureProvider.family<ForgotPassword, ParamsResetPassword>(
        (ref, params) async {
  final dio = ref.watch(dioProviderConstant);

  try {
    final response = await dio.post(
      '${ApiConstants.resetPasswordEndpoint}${params.noTelfon}',
      data: {
        'password': params.password,
        'confirm-password': params.confirmPassword
      },
      options: Options(
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

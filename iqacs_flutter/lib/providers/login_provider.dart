import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/models/res/res_model_login.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponse?>>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<AsyncValue<LoginResponse?>> {
  LoginNotifier() : super(const AsyncValue.data(null));

  Future<void> logout() async {
    try {
      state = const AsyncValue.loading();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      final response = await http.post(
        Uri.parse(ApiConstants.logoutEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(ApiConstants.timeoutDuration);

      log('Logout Response status: ${response.statusCode}');
      log('Logout Response body: ${response.body}');

      if (response.statusCode == 200) {
        await prefs.remove('access_token');
        state = const AsyncValue.data(null);
      } else {
        Map<String, dynamic> errorBody = json.decode(response.body);
        String errorMessage = errorBody['message'] ?? 'Logout gagal';
        state = AsyncValue.error(Exception(errorMessage), StackTrace.current);
        log('Logout error message: $errorMessage');
      }
    } on http.ClientException catch (_) {
      state = AsyncValue.error(
          Exception('Koneksi gagal: Periksa koneksi internet anda'),
          StackTrace.current);
      log('Koneksi gagal: Periksa koneksi internet anda');
    } on TimeoutException catch (_) {
      state = AsyncValue.error(
          Exception('Timeout: Server tidak merespon'), StackTrace.current);
      log('Timeout: Server tidak merespon');
    } catch (e) {
      state = AsyncValue.error(
          Exception('Terjadi kesalahan: ${e.toString()}'), StackTrace.current);
      log('Terjadi kesalahan: ${e.toString()}');
    }
  }

  Future<void> login(String identifier, String password) async {
    if (identifier.isEmpty || password.isEmpty) {
      state = AsyncValue.error(
        Exception('Identifier dan password tidak boleh kosong'),
        StackTrace.current,
      );
      return;
    }

    try {
      state = const AsyncValue.loading();

      final response = await http
          .post(
            Uri.parse(ApiConstants.loginEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'identifier': identifier,
              'password': password,
            }),
          )
          .timeout(ApiConstants.timeoutDuration);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final loginResponse = LoginResponse.fromJson(data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', loginResponse.accessToken ?? '');
        await prefs.setString('nama', loginResponse.pengguna?.nama ?? '');
        String fullFotoUrl =
            '${ApiConstants.baseUrl}${ApiConstants.fotoProfilPath}${loginResponse.pengguna?.foto ?? ''}';
        await prefs.setString('foto', fullFotoUrl);
        await prefs.setString('role', loginResponse.userOnline?.role ?? '');
        state = AsyncValue.data(loginResponse);
      } else {
        Map<String, dynamic> errorBody = json.decode(response.body);
        String errorMessage = errorBody['message'] ?? 'Login gagal';
        state = AsyncValue.error(Exception(errorMessage), StackTrace.current);
        log('Error message: $errorMessage');
      }
    } on http.ClientException catch (_) {
      state = AsyncValue.error(
          Exception('Koneksi gagal: Periksa koneksi internet anda'),
          StackTrace.current);
      log('Koneksi gagal: Periksa koneksi internet anda');
    } on TimeoutException catch (_) {
      state = AsyncValue.error(
          Exception('Timeout: Server tidak merespon'), StackTrace.current);
      log('Timeout: Server tidak merespon');
    } catch (e) {
      state = AsyncValue.error(
          Exception('Terjadi kesalahan: ${e.toString()}'), StackTrace.current);
      log('Terjadi kesalahan: ${e.toString()}');
    }
  }
}

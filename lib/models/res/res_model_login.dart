import 'package:iqacs/models/model_pengguna.dart';
import 'package:iqacs/models/model_user.dart';

class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final DateTime? expiresAt;
  final User? userOnline;
  final Pengguna? pengguna;
  final String? message;

  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.userOnline,
    this.pengguna,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'])
          : null,
      userOnline: json['user'] != null ? User.fromJson(json['user']) : null,
      pengguna:
          json['pengguna'] != null ? Pengguna.fromJson(json['pengguna']) : null,
      message: json['message'] as String?,
    );
  }
}

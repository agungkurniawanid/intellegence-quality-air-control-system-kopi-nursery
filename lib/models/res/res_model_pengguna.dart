import 'package:iqacs/models/model_pengguna.dart';

class ResModelPengguna {
  final String? status;
  final String? message;
  final Pengguna? pengguna;

  ResModelPengguna({
    this.status,
    this.message,
    this.pengguna,
  });

  factory ResModelPengguna.fromJson(Map<String, dynamic> json) {
    return ResModelPengguna(
      message: json['message'] as String?,
      status: json['status'] as String?,
      pengguna: json['data'] != null ? Pengguna.fromJson(json['data']) : null,
    );
  }
}

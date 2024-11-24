import 'package:iqacs/models/model_pengguna.dart';
import 'package:iqacs/models/model_user.dart';

class ResModelPengguna {
  final String? status;
  final String? message;
  final Pengguna? pengguna;
  final User? user;

  ResModelPengguna({
    this.status,
    this.message,
    this.pengguna,
    this.user,
  });

  factory ResModelPengguna.fromJson(Map<String, dynamic> json) {
    return ResModelPengguna(
      message: json['message'] as String?,
      status: json['status'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      pengguna:
          json['pengguna'] != null ? Pengguna.fromJson(json['pengguna']) : null,
    );
  }
}

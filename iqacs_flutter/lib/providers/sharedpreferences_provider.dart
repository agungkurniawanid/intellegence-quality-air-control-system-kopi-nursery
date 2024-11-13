import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userNameProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final fullName = prefs.getString('nama');
  if (fullName != null && fullName.isNotEmpty) {
    return fullName.split(' ')[0];
  }
  return null;
});

final userNameFullProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final fullName = prefs.getString('nama');
  if (fullName != null && fullName.isNotEmpty) {
    return fullName;
  }
  return null;
});

final userRoleProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role');
  if (role != null && role.isNotEmpty) {
    return role;
  }
  return null;
});

final userFotoProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final fotoUrl = prefs.getString('foto');
  if (fotoUrl != null && fotoUrl.isNotEmpty) {
    return fotoUrl;
  }
  return null;
});

final userEmailProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  if (email != null && email.isNotEmpty) {
    return email;
  }
  return '';
});

final userTelephoneProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final telepon = prefs.getString('no_telfon');
  if (telepon != null && telepon.isNotEmpty) {
    return telepon;
  }
  return '';
});

final userAddressProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final alamat = prefs.getString('alamat');
  if (alamat != null && alamat.isNotEmpty) {
    return alamat;
  }
  return '';
});

final userDescriptionProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final deskripsi = prefs.getString('deskripsi');
  if (deskripsi != null && deskripsi.isNotEmpty) {
    return deskripsi;
  }
  return '';
});

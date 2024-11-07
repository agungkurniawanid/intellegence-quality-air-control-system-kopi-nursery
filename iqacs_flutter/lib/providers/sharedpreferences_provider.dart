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

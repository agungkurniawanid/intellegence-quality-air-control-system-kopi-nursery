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

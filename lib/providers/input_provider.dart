import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordVisibilityProvider = StateProvider<bool>((ref) {
  return true;
});

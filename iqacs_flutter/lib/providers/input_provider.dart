import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk TextEditingController
final textControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

// Provider untuk visibilitas password
final passwordVisibilityProvider = StateProvider<bool>((ref) {
  return false;
});

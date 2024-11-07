import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final pageControllerProvider = Provider((ref) => PageController());

final selectedIndexOnboardingProvider = StateProvider<int>((ref) => 0);
final pageControllerOnboardingProvider = Provider((ref) => PageController());

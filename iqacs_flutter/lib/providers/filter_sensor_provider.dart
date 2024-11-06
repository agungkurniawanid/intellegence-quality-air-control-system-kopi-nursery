import 'package:flutter_riverpod/flutter_riverpod.dart';

final sensorDataProvider = StateProvider<List<String>>((ref) {
  return ["Alat 1", "Alat 2", "Alat 3", "Alat 4"];
});

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final switchStateProvider = StateProvider<bool>((ref) => false);

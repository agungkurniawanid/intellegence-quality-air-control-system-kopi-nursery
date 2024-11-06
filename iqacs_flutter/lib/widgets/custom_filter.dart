import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/providers/filter_sensor_provider.dart';
import 'package:iqacs/providers/get_temp_humidity_provider.dart';

class CustomFilterSuhuInformation extends ConsumerWidget {
  const CustomFilterSuhuInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorData = ref.watch(sensorDataProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFE8E8E8),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2,
        ),
        itemCount: sensorData.length,
        itemBuilder: (BuildContext context, int index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () async {
              ref.read(selectedIndexProvider.notifier).state = index;
              ref.read(sensorDataApiProvider(index + 1));
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF171717) : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Center(
                child: Text(
                  sensorData[index],
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : const Color(0xFF171717),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

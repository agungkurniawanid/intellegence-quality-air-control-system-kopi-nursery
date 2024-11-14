import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/functions/notification_func.dart';
import 'package:iqacs/functions/shimmer_card.dart';
import 'package:iqacs/providers/filter_sensor_provider.dart';
import 'package:iqacs/providers/get_temp_humidity_provider.dart';
import 'package:iqacs/providers/weather_provider.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

class CustomMainCard extends ConsumerWidget {
  const CustomMainCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const city = 'Darsono,Jember';
    final weatherValue = ref.watch(weatherProvider(city));

    return weatherValue.when(
      data: (weather) {
        return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Color(0xFFBFFA01),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.temperature.toStringAsFixed(2)} °C',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          double.parse(weather.temperature.toStringAsFixed(2)) <
                                      23.00 ||
                                  double.parse(weather.temperature
                                          .toStringAsFixed(2)) >
                                      26.00
                              ? 'TIDAK IDEAL'
                              : 'IDEAL TEMP',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/icons/weather-black.png",
                            width: MediaQuery.of(context).size.width / 3.5,
                            fit: BoxFit.cover),
                        Text(
                          "Darsono",
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kelembapan",
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Gap(5),
                        Text(
                          double.parse(weather.humidity.toStringAsFixed(2)) <=
                                      60.99 ||
                                  double.parse(weather.humidity
                                          .toStringAsFixed(2)) >=
                                      90.99
                              ? '${weather.humidity.toStringAsFixed(2)} % / IDEAL'
                              : '${weather.humidity.toStringAsFixed(2)} % / TIDAK IDEAL',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Suhu Ideal",
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF171717),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              Text(
                                "23° C",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF171717),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Gap(5),
                              const Icon(
                                Icons.arrow_upward,
                                color: Color(0xFF171717),
                                size: 20,
                              ),
                              const Gap(5),
                              Text(
                                "26° C",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF171717),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ]),
                  ],
                )
              ],
            ));
      },
      error: (error, stackTrace) {
        // Tangani kasus error
        return Center(
          child: Text('Error: $error'),
        );
      },
      loading: () {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: 80,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 70,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 90,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomCardSuhu extends ConsumerWidget {
  const CustomCardSuhu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedSensorData =
        ref.watch(sensorDataApiProvider(selectedIndex + 1));

    return selectedSensorData.when(
      data: (data) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.9,
          ),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            final sensorValue =
                index != 0 ? data.nilaiHumidity : data.nilaiTemperature;
            final sensorLabel = index != 0 ? "Kelembapan" : "Suhu";
            final sensorIdeal = index != 0
                ? "Ideal: 22.50 % - 27.50 %"
                : "Ideal: 18° C - 28° C";

            return Container(
              padding: const EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                color: Color(0xFFE8E8E8),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF171717),
                      ),
                      child: Center(
                        child: Image.asset(
                          index != 0
                              ? "assets/images/kelembapan.png"
                              : "assets/images/suhu.png",
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${sensorValue.toStringAsFixed(2)} ${index != 0 ? '%' : '° C'}",
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF171717),
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            sensorLabel,
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF171717),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.arrow_right_alt,
                              color: Color(0xFF171717), size: 20),
                        ],
                      ),
                      Text(
                        sensorIdeal,
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF171717),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => cardInformationSuhuHomeShimmerEffect(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

class CustomCardSprayer extends ConsumerWidget {
  const CustomCardSprayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchOn = ref.watch(switchStateProvider);
    final pumpApiService = ref.watch(pumpApiProvider);
    final logger = Logger();
    return Container(
      padding: const EdgeInsets.all(14.0),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFF171717),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/rain.png",
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final newState = !isSwitchOn;
                  ref.read(switchStateProvider.notifier).state = newState;
                  try {
                    await pumpApiService.togglePump();
                    if (context.mounted) {
                      if (newState) {
                        showNotificationSpraying(context, true);
                      } else {
                        showNotificationSpraying(context, false);
                      }
                    }
                  } catch (e) {
                    logger.d("Error: $e");
                  }
                },
                child: Container(
                  width: 30,
                  height: 60,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: isSwitchOn
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSwitchOn
                                ? Colors.blue
                                : const Color(0xFF171717),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "Penyemprotan Manual",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Aktifkan ketika suhu masuk 29° C atau lebih!",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class CustomCardReportInformation extends ConsumerWidget {
  const CustomCardReportInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.all(14.0),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: Color(0xFFE8E8E8),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Catatan Monitoring & Controlling",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const Gap(8),
            Text(
              "Laporan daftar riwayat monitoring, controlling! dan cetak laporan.",
              style: GoogleFonts.poppins(
                  color: const Color(0xFF171717),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFBFFA01),
              ),
              onPressed: () {},
              child: Text(
                "Lihat Laporan",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}

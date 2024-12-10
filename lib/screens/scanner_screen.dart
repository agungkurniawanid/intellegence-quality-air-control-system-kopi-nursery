import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iqacs/functions/snackbar_func.dart';
import 'package:iqacs/providers/diagnosa_provider.dart';
import 'package:iqacs/providers/forgot_password_provider.dart';
import 'package:iqacs/screens/analytic_screen.dart';
import 'package:iqacs/screens/predict_result_screen.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ScannerScreenState createState() => ScannerScreenState();
}

class ScannerScreenState extends ConsumerState<ScannerScreen> {
  Future<void> openFilePicker(BuildContext context, WidgetRef ref) async {
    final loadingNotifier = ref.read(loadingProvider.notifier);

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        try {
          loadingNotifier.state = true;

          final diagnosa = await ref.read(predictProvider(image).future);

          final message = diagnosa.success
              ? 'Prediksi berhasil: ${diagnosa.message ?? ''}'
              : 'Gagal: ${diagnosa.message ?? 'Tidak ada pesan error'}';

          logger.d(message);

          if (context.mounted) {
            if (diagnosa.success) {
              showSuccessSnackbar(context, 'Prediksi Berhasil dilakukan');
              if (diagnosa.diagnosis != null) {
                Timer(const Duration(seconds: 2), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PredictResultScreen()));
                });
              }
            } else {
              showErrorSnackbar(context, message);
            }
          }
        } catch (error) {
          logger.d('Gagal memproses gambar: $error');

          if (context.mounted) {
            showErrorSnackbar(context, 'Gagal memproses gambar: $error');
          }
        } finally {
          // Nonaktifkan loading
          loadingNotifier.state = false;
        }
      } else {
        logger.d('Tidak ada file yang dipilih');

        if (context.mounted) {
          showErrorSnackbar(context, 'Tidak ada file yang dipilih');
        }
      }
    } catch (error) {
      logger.d('Gagal mengunggah gambar: $error');

      if (context.mounted) {
        showErrorSnackbar(context, 'Gagal mengunggah gambar: $error');
      }
    } finally {
      // Pastikan loading dinonaktifkan
      loadingNotifier.state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> diagnosa = [
      {
        'image': 'assets/images/coffee-leaf/64.jpg',
        'diagnosis': '(700) Miner',
        'accuracy': '90,21% AKR',
        'date': '20 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/65.jpg',
        'diagnosis': '(701) Miner',
        'accuracy': '88,50% AKR',
        'date': '18 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/66.jpg',
        'diagnosis': '(702) Rust',
        'accuracy': '92,50% AKR',
        'date': '15 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/67.jpg',
        'diagnosis': '(703) Rust',
        'accuracy': '85,00% AKR',
        'date': '12 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/68.jpg',
        'diagnosis': '(704) Phoma',
        'accuracy': '91,00% AKR',
        'date': '10 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/69.jpg',
        'diagnosis': '(705) Phoma',
        'accuracy': '87,50% AKR',
        'date': '05 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/70.jpg',
        'diagnosis': '(706) Nodisease',
        'accuracy': '100,00% AKR',
        'date': '01 November 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/71.jpg',
        'diagnosis': '(707) Nodisease',
        'accuracy': '95,00% AKR',
        'date': '28 Oktober 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/72.jpg',
        'diagnosis': '(708) Miner',
        'accuracy': '89,75% AKR',
        'date': '25 Oktober 2024',
      },
      {
        'image': 'assets/images/coffee-leaf/73.jpg',
        'diagnosis': '(709) Rust',
        'accuracy': '90,00% AKR',
        'date': '22 Oktober 2024',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, top: 14),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/chatting.png'),
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deteksi",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 24,
                                    height: 0.8,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Penyakit Daun.",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Text(
                            "Deteksi penyakit daun kopi dengan menggunakan scanner dan analisis solusi dan diagnosa penyakit.",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          const Gap(10),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF171717),
                              foregroundColor: Colors.black,
                              minimumSize: const Size(100, 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              elevation: 8,
                              shadowColor: Colors.black.withOpacity(0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: Image.asset(
                              'assets/icons/camera.png',
                              width: 24,
                              height: 24,
                            ),
                            label: Text(
                              "Buka Kamera",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                        image: AssetImage('assets/icons/upload.png'),
                        width: 250,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Text(
                          "Upload Foto Daun",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Text(
                          "Upload foto daun bisa secara tunggal atau upload banyak foto sekaligus untuk analisis batch yang lebih cepat dan efisien.",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer(
                          builder: (context, ref, _) {
                            final isLoading = ref.watch(loadingProvider);
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () => openFilePicker(context, ref),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFBFFA01),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  fixedSize: const Size.fromHeight(60),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/icons/folder.png',
                                        width: 32,
                                        height: 32,
                                      ),
                                label: isLoading
                                    ? Text(
                                        "Loading...",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        "Buka Folder",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Diagnosa terbaru",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          "10 Items",
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF7B889B),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const Gap(30),
                    ...diagnosa.map((item) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0), // Jarak antar item
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: AssetImage(item['image']!),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Gap(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['diagnosis']!,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item['accuracy']!,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF7B889B),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item['date']!,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF7B889B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.delete_rounded,
                                    color: Color(0xFFF55858)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalyticScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      fixedSize: const Size.fromHeight(60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/icons/list.png',
                      width: 32,
                      height: 32,
                    ),
                    label: Text(
                      "Lihat Semua Riwayat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

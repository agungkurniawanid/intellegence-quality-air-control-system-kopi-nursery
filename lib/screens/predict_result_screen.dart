import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/models/model_data_predict.dart';
import 'package:iqacs/providers/diagnosa_provider.dart';
import 'package:iqacs/providers/forgot_password_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PredictResultScreen extends ConsumerStatefulWidget {
  const PredictResultScreen({super.key});

  @override
  ConsumerState<PredictResultScreen> createState() =>
      _PredictResultScreenState();
}

class _PredictResultScreenState extends ConsumerState<PredictResultScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final getResultDiagnosaHandle =
        ref.watch(getResultDataDiagnosaProvider("terbaru"));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    getResultDiagnosaHandle.when(
                      data: (data) {
                        if (data is SuccessResponsePredict) {
                          logger.d(data.data.file);
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                  "${ApiConstants.fotoDiagnosaPath}${data.data.file}"),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Image(
                            image: const AssetImage(
                                "assets/images/masonry/masonry (1).jpg"),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const Text('Unknown data type');
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color:
                                                Colors.white), // Ikon kembali
                                        onPressed: () {
                                          // Tindakan saat ikon ditekan
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Spacer(), // Menjaga jarak antara ikon dan batas kanan
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // todo: title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getResultDiagnosaHandle.when(
                      data: (data) {
                        if (data is SuccessResponsePredict) {
                          logger.d(data.data.diagnosa);
                          final diagnosaCapitalized = data.data.diagnosa
                              .split(' ')
                              .map((word) => word.isNotEmpty
                                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                                  : word)
                              .join(' ');

                          return Text(
                            "(${data.data.id}) $diagnosaCapitalized",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF171717),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (data is ErrorResponsePredict) {
                          return const Text('Default Text!');
                        } else {
                          return const Text('Unknown Data');
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    getResultDiagnosaHandle.when(
                      data: (data) {
                        if (data is SuccessResponsePredict) {
                          logger.d(data.data.diagnosa);

                          // Mengubah nilai akurasi menjadi double dan format menjadi persentase
                          final akurasiDouble = double.tryParse(
                                  data.data.keakuratan.replaceAll('%', '')) ??
                              0.0;
                          final akurasiFormatted =
                              '${akurasiDouble.toStringAsFixed(2)}%'; // Mengatur menjadi 2 desimal

                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFBFFA01),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "Akurasi: $akurasiFormatted",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF171717),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else if (data is ErrorResponsePredict) {
                          return const Text('Default Text!');
                        } else {
                          return const Text('Unknown Data');
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 30,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  ],
                ),
                // todo: deskripsi analisis
                const SizedBox(height: 10),
                getResultDiagnosaHandle.when(
                  data: (data) {
                    if (data is SuccessResponsePredict) {
                      final animationNotifier =
                          ref.read(loadingProvider.notifier);
                      final isAnimationFinished = ref.watch(loadingProvider);
                      return isAnimationFinished
                          ? TexMarkdown(
                              '''${data.data.deskripsi}''',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            )
                          : AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "${data.data.deskripsi}",
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                  speed: const Duration(milliseconds: 7),
                                ),
                              ],
                              onFinished: () {
                                animationNotifier.state = true;
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });
                              },
                            );
                    } else if (data is ErrorResponsePredict) {
                      return const Text('Default Text!');
                    } else {
                      return const Text('Unknown Data');
                    }
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      'Terjadi kesalahan: $error',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  loading: () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 150,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: Colors.grey[300]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 250,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: Colors.grey[300]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

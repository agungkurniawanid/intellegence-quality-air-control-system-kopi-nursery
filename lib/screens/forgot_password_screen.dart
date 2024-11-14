import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:iqacs/providers/forgot_password_provider.dart';
import 'package:iqacs/screens/otp_verification_screen.dart';
import 'package:iqacs/functions/snackbar_func.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController phoneController;
  late FocusNode phoneFocusNode;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage("assets/icons/forgotpasword.png"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Lupa\nPassword?",
                  style: GoogleFonts.poppins(
                      fontSize: 38.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  'Untuk melanjutkan reset password silahkan memasukkan nomor telephone',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "ex: 08xxxxxxxxxx",
                    hintStyle:
                        GoogleFonts.poppins(color: const Color(0xFF6C798F)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFFDFE1E5)),
                    ),
                  ),
                ),
              ),
              const Gap(14.0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final phoneNumber = phoneController.text;

                      if (phoneNumber.isEmpty) {
                        showErrorSnackbar(
                            context, "Nomor telepon tidak boleh kosong.");
                        return;
                      }

                      ref.read(loadingProvider.notifier).state = true;

                      try {
                        final forgotPasswordResponse = await ref
                            .read(forgotPasswordProvider(phoneNumber).future);

                        if (forgotPasswordResponse.status == 'success' &&
                            context.mounted) {
                          showSuccessSnackbar(
                              context, "OTP berhasil dikirim via WhatsApp!");
                          Future.delayed(const Duration(seconds: 2), () {
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerificationScreen(
                                    noTelfon: phoneNumber,
                                  ),
                                ),
                              );
                            }
                          });
                        } else {
                          if (context.mounted) {
                            showErrorSnackbar(
                                context, forgotPasswordResponse.message);
                          }
                        }
                      } catch (e) {
                        if (e is DioException) {
                          if (e.response?.statusCode == 302) {
                            if (context.mounted) {
                              showErrorSnackbar(context,
                                  "Sedang dialihkan, silakan coba lagi.");
                            }
                          } else {
                            if (context.mounted) {
                              showErrorSnackbar(context,
                                  "Terjadi kesalahan jaringan: ${e.message}");
                            }
                          }
                        } else {
                          if (context.mounted) {
                            showErrorSnackbar(context, "Terjadi kesalahan: $e");
                          }
                        }
                      } finally {
                        ref.read(loadingProvider.notifier).state = false;
                      }
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
                    label: Consumer(
                      builder: (context, watch, child) {
                        final isLoading = ref.watch(loadingProvider);
                        return isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Loading...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            : Text(
                                "Kirim Kode OTP",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

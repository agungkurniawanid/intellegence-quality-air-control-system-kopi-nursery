import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:iqacs/screens/reset_password.dart';

class OtpVerificationScreen extends ConsumerWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: const AssetImage("assets/icons/checkotp.png"),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Masukkan\nKode OTP.",
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
                    )),
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10.0),
                  child: OtpTextField(
                    numberOfFields: 4,
                    borderColor: Colors.black,
                    disabledBorderColor: Colors.white,
                    cursorColor: Colors.black,
                    enabledBorderColor: Colors.black,
                    showFieldAsBox: true,
                    borderRadius: BorderRadius.circular(10),
                    fieldWidth: MediaQuery.of(context).size.width / 6,
                    fillColor: const Color(0xFFF1F5F6),
                    filled: true,
                    focusedBorderColor: Colors.black,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Jarak antar field
                    onCodeChanged: (String code) {
                      // handle validation or checks here
                    },
                    onSubmit: (String verificationCode) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Gap(14.0),
                Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()));
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
                        label: Text(
                          "Verifikasi Kode OTP",
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
        ));
  }
}

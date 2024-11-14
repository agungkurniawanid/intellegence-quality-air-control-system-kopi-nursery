import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:iqacs/screens/otp_verification_screen.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

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
                    )),
                const Gap(10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: TextField(
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OtpVerificationScreen()));
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
                          "Kirim Kode OTP",
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

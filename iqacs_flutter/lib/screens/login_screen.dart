import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/screens/page_screen.dart';
import 'package:iqacs/widgets/custom_input.dart';

class LoginScreen extends ConsumerWidget {
  final String title;

  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const Gap(20),
                  Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF171717),
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "IQACS Kopi Nursery",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF42A510),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Gap(60),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const CustomInput(
                          placeholder: "contoh: 08xxxxxxxxxx",
                          type: TextInputType.number,
                          labelText: "Masukkan Nomor Telephone:",
                        ),
                        const Gap(20),
                        const CustomInput(
                          placeholder: ".......",
                          type: TextInputType.visiblePassword,
                          labelText: "Masukkan Password:",
                          isPassword: true,
                        ),
                        const Gap(10),
                        Text("Lupa Password?",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF42A510),
                                decoration: TextDecoration.underline)),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PageScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42A510),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Masuk Akun",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

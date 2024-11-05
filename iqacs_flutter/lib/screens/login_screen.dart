import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/providers/input_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iqacs/providers/login_provider.dart';
import 'package:iqacs/screens/page_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String title;

  const LoginScreen({super.key, required this.title});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final phoneController = ref.watch(phoneControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final loginResponse = ref.watch(loginProvider);

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
                  ).animate().fadeIn(duration: 1000.ms),
                  const Gap(20),
                  Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF171717),
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ).animate().fadeIn(duration: 1500.ms),
                      Text(
                        "IQACS Kopi Nursery",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF42A510),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ).animate().fadeIn(duration: 3000.ms),
                    ],
                  ),
                  const Gap(60),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          cursorColor: const Color(0xFF42A510),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: "contoh: 08xxxxxxxxxx",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xFF42A510), width: 2),
                            ),
                          ),
                        ).animate().fadeIn(duration: 1200.ms).slideX(),
                        const Gap(20),
                        TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ref.watch(passwordVisibilityProvider),
                          cursorColor: const Color(0xFF42A510),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: ".......",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xFF42A510), width: 2),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                ref.watch(passwordVisibilityProvider)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                ref
                                        .read(passwordVisibilityProvider.notifier)
                                        .state =
                                    !ref.watch(passwordVisibilityProvider);
                              },
                            ),
                          ),
                        ).animate().fadeIn(duration: 1200.ms).slideX(),
                        const Gap(10),
                        Text("Lupa Password?",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF42A510),
                                    decoration: TextDecoration.underline))
                            .animate()
                            .fadeIn(duration: 1200.ms),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: () async {
                            final phone = phoneController.text;
                            final password = passwordController.text;

                            if (phone.isEmpty || password.isEmpty) {
                              const snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Kesalahan',
                                  message:
                                      'Identifier dan password tidak boleh kosong!',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }

                            await ref
                                .read(loginProvider.notifier)
                                .login(phone, password);
                            final loginResponse = ref.read(loginProvider);

                            if (loginResponse.hasValue) {
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PageScreen(),
                                  ),
                                );
                              }
                            } else if (loginResponse.hasError) {
                              String errorMessage =
                                  loginResponse.error.toString();
                              if (errorMessage.contains(
                                  'Username pengguna tidak ditemukan')) {
                                errorMessage = 'Pengguna tidak ditemukan!';
                              } else if (errorMessage
                                  .contains('Password anda salah')) {
                                errorMessage = 'Password salah!';
                              }

                              if (context.mounted) {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Kesalahan',
                                    message: errorMessage,
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                return;
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42A510),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: loginResponse.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  "Masuk Akun",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                        ).animate().fadeIn(duration: 1200.ms).slideY(),
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

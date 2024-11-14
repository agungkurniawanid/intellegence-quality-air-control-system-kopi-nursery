import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/screens/login_screen.dart';

class ResetPassword extends ConsumerStatefulWidget {
  final String noTelfon;
  const ResetPassword({super.key, required this.noTelfon});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends ConsumerState<ResetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                image: const AssetImage("assets/icons/newpassword.png"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Reset\nPassword?",
                  style: GoogleFonts.poppins(
                      fontSize: 38.0, fontWeight: FontWeight.w500),
                ),
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: TextField(
                  controller: _newPasswordController,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "New password",
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
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: TextField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Confirm password",
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
                      if (_newPasswordController.text ==
                          _confirmPasswordController.text) {
                        // Add your reset password logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LoginScreen(title: 'Login'),
                          ),
                        );
                      } else {
                        // Show a message indicating that passwords do not match
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
                    label: Text(
                      "Submit Perubahan",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

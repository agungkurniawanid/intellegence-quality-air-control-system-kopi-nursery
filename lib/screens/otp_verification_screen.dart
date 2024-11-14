import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:iqacs/providers/check_otp_provider.dart';
import 'package:iqacs/functions/snackbar_func.dart';
import 'package:iqacs/providers/forgot_password_provider.dart';
import 'package:iqacs/screens/reset_password.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String noTelfon;
  const OtpVerificationScreen({super.key, required this.noTelfon});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  String _otpCode = '';
  bool get _canResendCode => ref.watch(timerProvider) == 0;

  @override
  void initState() {
    super.initState();
    ref.read(timerProvider.notifier).startTimer();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _resendCode() {
    ref.watch(timerProvider.notifier).resetTimer();
    ref.watch(resendOtpProvider(widget.noTelfon).future).then((response) {
      logger.d('Resend OTP Response: ${response.status}, ${response.message}');

      if (mounted) {
        if (response.status == 'success') {
          showSuccessSnackbar(context, response.message);
        } else {
          showErrorSnackbar(context, response.message);
        }
      }
    }).catchError((error) {
      logger.d('Error saat resend OTP: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Terjadi kesalahan saat mengirim ulang OTP: $error'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void _verifyOtp() {
    if (_otpCode.length == 4) {
      ref.read(loadingProvider.notifier).state = true;
      ref
          .read(
              checkOtpProvider({'no_telfon': widget.noTelfon, 'otp': _otpCode})
                  .future)
          .then((response) {
        ref.read(loadingProvider.notifier).state = false;

        if (mounted) {
          if (response.status == 'success') {
            showSuccessSnackbar(context, response.message);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResetPassword(noTelfon: widget.noTelfon);
            }));
          } else if (response.status == 'error' &&
              response.message ==
                  'Kode OTP yang Anda masukkan telah kadaluarsa.') {
            showErrorSnackbar(context, response.message);
          } else {
            showErrorSnackbar(context, response.message);
          }
        }
      }).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Terjadi kesalahan: $error'),
            backgroundColor: Colors.red,
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Mohon masukkan kode OTP dengan lengkap'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final remainingSeconds = ref.watch(timerProvider);

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
                  'Untuk melanjutkan reset password silahkan memasukkan kode OTP',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Gap(10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                child: OtpTextField(
                  numberOfFields: 4,
                  keyboardType: TextInputType.number,
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
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  onCodeChanged: (String code) {
                    setState(() {
                      _otpCode = code;
                    });
                  },
                  onSubmit: (String verificationCode) {
                    setState(() {
                      _otpCode = verificationCode;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kode OTP kadaluarsa dalam ${_formatTime(remainingSeconds)}',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      onPressed: _canResendCode ? _resendCode : null,
                      child: Text(
                        'Kirim Ulang',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: _canResendCode ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        fixedSize: const Size.fromHeight(60),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Consumer(builder: (context, ref, child) {
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
                                "Verifikasi Kode OTP",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                      })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

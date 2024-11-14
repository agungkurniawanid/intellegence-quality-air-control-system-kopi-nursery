import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

class CustomInput extends ConsumerWidget {
  final String placeholder;
  final bool isPassword;
  final TextInputType type;
  final TextEditingController? controller;
  final String labelText;

  const CustomInput({
    super.key,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
    this.type = TextInputType.text,
    required this.labelText,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured =
        isPassword ? ref.watch(passwordVisibilityProvider) : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const Gap(10),
        TextField(
          controller: controller,
          keyboardType: type,
          obscureText: isObscured,
          cursorColor: const Color(0xFF42A510),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
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
              borderSide: const BorderSide(color: Color(0xFF42A510), width: 2),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).state =
                          !isObscured;
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

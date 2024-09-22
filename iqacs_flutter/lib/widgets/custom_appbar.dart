import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Row(
          children: [
            ClipOval(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: const ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/agung.jpg'),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pagi, Agung!",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF171717),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                Text("Senin, 22 September 2024",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF171717),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            )
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Color(0xFFE8E8E8),
              ),
              child: Image.asset(
                'assets/icons/bell-black.png',
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

void showNotificationSpraying(BuildContext context, bool isSwitchOn) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * -50),
                child: child,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSwitchOn ? const Color(0xFF171717) : Colors.red,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/${isSwitchOn ? 'semprot' : 'nonaktif-spray'}.png",
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const Gap(10),
                  Expanded(
                    // Wrap the column with Expanded to ensure proper space management.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Penyemprotan ${isSwitchOn ? 'Diaktifkan' : 'Dimatikan'}!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Prevents overflow with ellipsis
                          softWrap:
                              true, // Ensures wrapping if the text is too long
                        ),
                        const SizedBox(
                            height:
                                4), // Adds a little space between the two texts
                        Text(
                          "Penyemprotan ${isSwitchOn ? 'diaktifkan' : 'dimatikan'}, untuk ${isSwitchOn ? 'menonaktifkan' : 'mengaktifkan'} silahkan tekan ulang tombol!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow
                              .visible, // Allows overflow to be visible
                          softWrap: true, // Enables wrapping of the text
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
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(milliseconds: 1700), () {
    if (overlayEntry.mounted) {
      overlayEntry.markNeedsBuild(); // Start fade-out animation
    }
  });

  Future.delayed(const Duration(seconds: 2), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}

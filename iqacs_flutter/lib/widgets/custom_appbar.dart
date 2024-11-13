import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/providers/sharedpreferences_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userNameProvider);
    final userFoto = ref.watch(userFotoProvider);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM y').format(now);

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
                    child: ClipOval(
                      child: userFoto.when(
                        data: (fotoUrl) {
                          return fotoUrl != null && fotoUrl.isNotEmpty
                              ? Image.network(
                                  fotoUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/agung.jpg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                );
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        error: (err, stack) => Image.asset(
                          'assets/images/agung.jpg',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
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
                userName.when(
                  data: (userName) => Text(
                    "Pagi, ${userName ?? 'User'}!",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF171717),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text(
                    "Pagi, User!",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF171717),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(formattedDate,
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

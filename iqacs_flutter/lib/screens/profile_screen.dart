import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> listItem = [
      {
        "icon": Icons.person_rounded,
        "text": "Personal Data",
      },
      {
        "icon": Icons.key_rounded,
        "text": "Hak Akses",
      },
      {
        "icon": Icons.lock_rounded,
        "text": "Ubah Password",
      },
      {
        "icon": Icons.help_rounded,
        "text": "Bantuan",
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // todo: profile picture, name and status(owner, karyawan)
              Row(
                children: [
                  // todo: image picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/images/agung.jpg'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(20),
                  // todo: name and status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // todo: name
                      Text(
                        'Agung Pratama',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // todo: status
                      Text('owner',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4A6783),
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              // todo: divider garis pembatas
              const Divider(
                color: Color(0xFFE8E8E8),
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              const Gap(20),
              // todo list item
              Column(
                children: [
                  ...listItem.map(
                    (item) => GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFF1F3FD),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Icon(
                                    item['icon'],
                                    color: const Color(0xFF002851),
                                    size: 28,
                                  ),
                                ),
                                const Gap(20),
                                Text(item['text'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF002851),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

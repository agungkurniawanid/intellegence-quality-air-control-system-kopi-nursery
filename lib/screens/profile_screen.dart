import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/providers/login_provider.dart';
import 'package:iqacs/providers/sharedpreferences_provider.dart';
import 'package:iqacs/providers/user_provider.dart';
import 'package:iqacs/screens/edit_profile_screen.dart';
import 'package:iqacs/screens/login_screen.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFoto = ref.watch(userFotoProvider);
    final userName = ref.watch(userNameFullProvider);
    final userRole = ref.watch(userRoleProvider);
    final penggunaResponse = ref.watch(getDataPenggunaProvider);

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
      {
        "icon": Icons.logout_rounded,
        "text": "Logout",
      }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: penggunaResponse.when(
                      data: (fotoUrl) {
                        return fotoUrl.pengguna?.foto != null
                            ? Image.network(
                                '${ApiConstants.baseUrl}${ApiConstants.fotoProfilPath}${fotoUrl.pengguna?.foto}',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/agung.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              );
                      },
                      loading: () => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      error: (err, stack) => const Icon(Icons.error),
                    ),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // todo: name
                      userName.when(
                        data: (name) {
                          return Text("$name",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ));
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: 100,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        error: (err, stack) => const Icon(Icons.error),
                      ),
                      // todo: status
                      userRole.when(
                        data: (role) {
                          String capitalizedRole = role!
                              .split(' ')
                              .map((word) => word.isNotEmpty
                                  ? word[0].toUpperCase() +
                                      word.substring(1).toLowerCase()
                                  : '')
                              .join(' ');
                          return Text(capitalizedRole,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF4A6783),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ));
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: 100,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        error: (err, stack) => const Icon(Icons.error),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              const Divider(
                color: Color(0xFFE8E8E8),
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              const Gap(20),
              Column(
                children: [
                  ...listItem.map(
                    (item) => GestureDetector(
                      onTap: () {
                        if (item['text'] == 'Logout') {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            title: 'Konfirmasi Logout',
                            text: 'Apakah Anda yakin ingin logout?',
                            confirmBtnText: 'Ya',
                            cancelBtnText: 'Batal',
                            onConfirmBtnTap: () {
                              ref.read(loginProvider.notifier).logout();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen(
                                        title: 'Login',
                                      )));
                            },
                            onCancelBtnTap: () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                        if (item['text'] == 'Personal Data') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                        }
                      },
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

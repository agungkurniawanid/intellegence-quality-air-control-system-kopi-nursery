import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/functions/snackbar_func.dart';
import 'package:iqacs/providers/forgot_password_provider.dart';
import 'package:iqacs/providers/profile_provider.dart';
import 'package:iqacs/providers/user_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  Future<void> _handleImageSelection(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(
                  'Ambil Foto',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAndUploadImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(
                  'Pilih dari Galeri',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAndUploadImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        final fileName = pickedFile.name.replaceAll('scaled_', '');
        if (!['jpeg', 'jpg', 'png']
            .contains(file.path.split('.').last.toLowerCase())) {
          if (mounted) {
            showErrorSnackbar(context,
                'File harus berupa gambar dengan format jpg, jpeg, atau png');
          }
          return;
        }
        if (fileSize > 2 * 1024 * 1024) {
          if (mounted) {
            showErrorSnackbar(
                context, 'Ukuran file tidak boleh lebih dari 2 MB');
          }
          return;
        }

        final updateProfileResult = await ref.read(
          updateProfileProvider(pickedFile).future,
        );

        if (updateProfileResult.status == 'success') {
          if (mounted) {
            ref.invalidate(getDataPenggunaProvider);
            showSuccessSnackbar(context, updateProfileResult.message);
            logger.d(updateProfileResult.message);
            logger.d(fileName);
          }
        } else {
          if (mounted) {
            showErrorSnackbar(context, updateProfileResult.message);
            logger.d(updateProfileResult.message);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
        logger.d(e.toString());
      }
    }
  }

  final List<TextEditingController> controllers = [];
  final inputLabels = [
    'Nama Lengkap',
    'Email',
    'No. Telepon',
    'Alamat',
    'Bio',
  ];

  @override
  void initState() {
    super.initState();
    final penggunaResponse = ref.read(getDataPenggunaProvider);
    controllers.addAll([
      TextEditingController(
          text: penggunaResponse.when(
        data: (data) => data.pengguna?.nama ?? '',
        loading: () => '',
        error: (err, stack) => '',
      )),
      TextEditingController(
          text: penggunaResponse.when(
        data: (data) => data.user?.email,
        loading: () => '',
        error: (err, stack) => '',
      )),
      TextEditingController(
          text: penggunaResponse.when(
        data: (data) => data.user?.noTelepon,
        loading: () => '',
        error: (err, stack) => '',
      )),
      TextEditingController(
          text: penggunaResponse.when(
        data: (data) => data.pengguna?.alamat,
        loading: () => '',
        error: (err, stack) => '',
      )),
      TextEditingController(
          text: penggunaResponse.when(
        data: (data) => data.pengguna?.deskripsi,
        loading: () => '',
        error: (err, stack) => '',
      )),
    ]);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final penggunaResponse = ref.watch(getDataPenggunaProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Personal Data or Edit Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color(0xFF162233).withOpacity(0.08),
                spreadRadius: -4,
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: ClipOval(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: ClipOval(
                            child: penggunaResponse.when(
                              data: (fotoUrl) {
                                return fotoUrl.pengguna?.foto != null
                                    ? Image.network(
                                        '${ApiConstants.baseUrl}${ApiConstants.fotoProfilPath}${fotoUrl.pengguna?.foto}',
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/agung.jpg',
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      );
                              },
                              loading: () => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              error: (err, stack) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: ClipOval(
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFFBFFA01)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 28,
                          ),
                          onPressed: () => _handleImageSelection(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: inputLabels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        labelText: inputLabels[index],
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        hintText:
                            'Masukkan ${inputLabels[index].toLowerCase()}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      ref.read(loadingProvider.notifier).state = true;
                      try {
                        final params = ParamsUpdateDatPengguna(
                          email: controllers[1].text,
                          notTelfon: controllers[2].text,
                          namaLengkap: controllers[0].text,
                          alamat: controllers[3].text,
                          deskripsi: controllers[4].text,
                        );
                        logger
                            .d('Memulai reset password dengan params: $params');
                        final responseServer = await ref.read(
                            updateDataPenggunaWithoutPhoto(params).future);
                        logger.d(
                            'Respons dari server: ${responseServer.message}, Status: ${responseServer.status}');
                        if (context.mounted) {
                          if (responseServer.message != null) {
                            ref.invalidate(getDataPenggunaProvider);
                            showSuccessSnackbar(
                                context, responseServer.message!);
                          } else {
                            showErrorSnackbar(context, 'Unknown error');
                          }
                        }
                      } catch (e, stackTrace) {
                        logger.d('Terjadi kesalahan selama reset password: $e');
                        logger.d('Stack trace: $stackTrace');
                        if (context.mounted) {
                          showErrorSnackbar(
                              context, 'Terjadi kesalahan: ${e.toString()}');
                        }
                      } finally {
                        ref.read(loadingProvider.notifier).state = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      fixedSize: const Size.fromHeight(50),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    label: Consumer(builder: (context, ref, child) {
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
                                  "Menyimpan...",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : Text(
                              "Update Data",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                    })),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailAnalyticScreen extends ConsumerWidget {
  const DetailAnalyticScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // todo image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: const AssetImage(
                            "assets/images/masonry/masonry (6).jpg"),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color:
                                                Colors.white), // Ikon kembali
                                        onPressed: () {
                                          // Tindakan saat ikon ditekan
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Spacer(), // Menjaga jarak antara ikon dan batas kanan
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // todo: title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "(701) Phoma",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF171717),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBFFA01),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "Akurasi: 90,10%",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF171717),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                // todo: deskripsi analisis
                const SizedBox(height: 10),
                Text(
                  "Rhizoctonia solani adalah patogen tular tanah yang dapat menyebabkan penyakit rebah batang/rebah kecambah/damping off pada benih tanaman kopi.",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                // todo: Gejala
                Text(
                  "Gejala:",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Penyakit Phoma pada daun kopi ditandai dengan munculnya lesi tidak teratur pada daun tua, yang awalnya berwarna kuning hingga coklat. Seiring perkembangan penyakit, lesi ini akan membesar menjadi bercak yang lebih besar dan berubah menjadi area nekrotik yang kusam, dengan pusat berwarna abu-abu dan tepi yang gelap. Pada tahap akhir infeksi, daun yang terinfeksi mulai layu dan mengalami kerontokan, yang dapat menyebabkan tanaman menjadi gundul jika tidak ditangani dengan baik.",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                // todo: solusi
                Text(
                  "Solusi:",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Untuk mencegah dan mengendalikan penyakit Phoma pada tanaman kopi, beberapa langkah pengendalian kultural dapat diterapkan secara efektif. Pertama, menjaga kebersihan kebun sangat penting; petani harus secara rutin menghilangkan daun-daun yang terinfeksi dan sisa-sisa tanaman untuk mengurangi sumber infeksi. Selain itu, melakukan rotasi tanaman dapat membantu memutus siklus hidup jamur dan mencegah penyebaran penyakit",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

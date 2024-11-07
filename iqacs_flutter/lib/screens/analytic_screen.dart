import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iqacs/screens/detail_analytic_screen.dart';

class AnalyticScreen extends ConsumerStatefulWidget {
  const AnalyticScreen({super.key});

  @override
  ConsumerState<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends ConsumerState<AnalyticScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> diagnosa = [
      {
        'image': 'assets/images/coffee-leaf/64.jpg',
        'diagnosis': '(700) Miner',
        'accuracy': '90,21%',
      },
      {
        'image': 'assets/images/coffee-leaf/65.jpg',
        'diagnosis': '(701) Miner',
        'accuracy': '88,50%',
      },
      {
        'image': 'assets/images/coffee-leaf/66.jpg',
        'diagnosis': '(702) Rust',
        'accuracy': '92,50%',
      },
      {
        'image': 'assets/images/coffee-leaf/67.jpg',
        'diagnosis': '(703) Rust',
        'accuracy': '85,00%',
      },
      {
        'image': 'assets/images/coffee-leaf/68.jpg',
        'diagnosis': '(704) Phoma',
        'accuracy': '91,00%',
      },
      {
        'image': 'assets/images/coffee-leaf/69.jpg',
        'diagnosis': '(705) Phoma',
        'accuracy': '87,50%',
      },
      {
        'image': 'assets/images/coffee-leaf/70.jpg',
        'diagnosis': '(706) Nodisease',
        'accuracy': '100,00%',
      },
      {
        'image': 'assets/images/coffee-leaf/71.jpg',
        'diagnosis': '(707) Nodisease',
        'accuracy': '95,00%',
      },
      {
        'image': 'assets/images/coffee-leaf/72.jpg',
        'diagnosis': '(708) Miner',
        'accuracy': '89,75%',
      },
      {
        'image': 'assets/images/coffee-leaf/73.jpg',
        'diagnosis': '(709) Rust',
        'accuracy': '90,00%',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Riwayat Analisis',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Text(
                  "Terbaru",
                  style: GoogleFonts.poppins(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                            width: 130,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      diagnosa[index]['image'] ?? ''),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              diagnosa[index]['diagnosis'] ??
                                                  '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          const SizedBox(height: 2.0),
                                          Text(
                                              diagnosa[index]['accuracy'] ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                        ],
                                      )),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8.0),
                ),
              ),
              const Expanded(child: TabBarViewWidgetScannerScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBarViewWidgetScannerScreen extends ConsumerStatefulWidget {
  const TabBarViewWidgetScannerScreen({super.key});

  @override
  ConsumerState<TabBarViewWidgetScannerScreen> createState() =>
      _TabBarViewWidgetScannerScreenState();
}

class _TabBarViewWidgetScannerScreenState
    extends ConsumerState<TabBarViewWidgetScannerScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> masonryminer = [
      {
        'image': 'assets/images/masonry/masonry (1).jpg',
        'diagnosis': '(700) Miner',
        'accuracy': '90,21%',
      },
      {
        'image': 'assets/images/masonry/masonry (2).jpg',
        'diagnosis': '(701) Miner',
        'accuracy': '88,50%',
      },
      {
        'image': 'assets/images/masonry/masonry (3).jpg',
        'diagnosis': '(702) Rust',
        'accuracy': '92,50%',
      },
      {
        'image': 'assets/images/masonry/masonry (4).jpg',
        'diagnosis': '(703) Rust',
        'accuracy': '85,00%',
      },
      {
        'image': 'assets/images/masonry/masonry (5).jpg',
        'diagnosis': '(704) Phoma',
        'accuracy': '91,00%',
      },
      {
        'image': 'assets/images/masonry/masonry (6).jpg',
        'diagnosis': '(705) Phoma',
        'accuracy': '87,50%',
      },
      {
        'image': 'assets/images/masonry/masonry (7).jpg',
        'diagnosis': '(706) Nodisease',
        'accuracy': '100,00%',
      },
      {
        'image': 'assets/images/masonry/masonry (8).jpg',
        'diagnosis': '(707) Nodisease',
        'accuracy': '95,00%',
      },
      {
        'image': 'assets/images/masonry/masonry (9).jpg',
        'diagnosis': '(708) Miner',
        'accuracy': '89,75%',
      },
      {
        'image': 'assets/images/masonry/masonry (10).jpg',
        'diagnosis': '(709) Rust',
        'accuracy': '90,00%',
      },
    ];
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          TabBar(
            indicatorColor: const Color(0xFFBFFA01),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            labelColor: Colors.black,
            indicatorWeight: 5,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: const Color(0xFF9C9C9C),
            tabs: [
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Semua',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Miner',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Phoma',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Nodisease',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Rust',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: MasonryGridView.builder(
                    itemCount: 10,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DetailAnalyticScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 2.0, top: 8.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    masonryminer[index]['image'] ?? '',
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(height: 2.0),
                              Text('(700) Miner, 90,21% Accuracy',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                    child: Text('Konten Miner',
                        style: GoogleFonts.poppins(fontSize: 16))),
                Center(
                    child: Text('Konten Phoma',
                        style: GoogleFonts.poppins(fontSize: 16))),
                Center(
                    child: Text('Konten Nodisease',
                        style: GoogleFonts.poppins(fontSize: 16))),
                Center(
                    child: Text('Konten Rust',
                        style: GoogleFonts.poppins(fontSize: 16))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

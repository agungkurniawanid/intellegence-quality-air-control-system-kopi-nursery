import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/models/model_data_predict.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:iqacs/providers/diagnosa_provider.dart';
import 'package:iqacs/screens/detail_analytic_screen.dart';
import 'package:shimmer/shimmer.dart';

class AnalyticScreen extends ConsumerStatefulWidget {
  const AnalyticScreen({super.key});

  @override
  ConsumerState<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends ConsumerState<AnalyticScreen> {
  @override
  Widget build(BuildContext context) {
    final diagnosa = ref.watch(getResultDataDiagnosaProvider("recent"));
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
                  child: diagnosa.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailAnalyticScreen(
                                              id: listData[index]
                                                  .id
                                                  .toString()),
                                      maintainState: true,
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                      width: 130,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${ApiConstants.fotoDiagnosaPath}${listData[index].file}"),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        listData[index]
                                                            .diagnosa,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(height: 2.0),
                                                    Text(
                                                        '${(double.tryParse(listData[index].keakuratan.replaceAll("%", "")) ?? 0.0).toStringAsFixed(2)}%',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white)),
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
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () {
                        const shimmerCount = 2;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: List.generate(
                              shimmerCount,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Container(
                                      width: 130,
                                      height:
                                          250, // Sesuaikan tinggi shimmer dengan tinggi SizedBox
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
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
    final all = ref.watch(getResultDataDiagnosaProvider("semua"));
    final miner = ref.watch(getResultDataDiagnosaProvider("miner"));
    final phoma = ref.watch(getResultDataDiagnosaProvider("phoma"));
    final health = ref.watch(getResultDataDiagnosaProvider("health"));
    final rust = ref.watch(getResultDataDiagnosaProvider("rust"));
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
                  child: all.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          logger.d("JUMLAH MASONARY : ${listData.length}");
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return MasonryGridView.builder(
                            itemCount: listData.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final item = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalyticScreen(
                                              id: item.id.toString(),
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            "${ApiConstants.fotoDiagnosaPath}${item.file}",
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(height: 2.0),
                                      Text(
                                          '(${item.id}) ${item.diagnosa}, ${item.keakuratan}% Accuracy',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => MasonryGridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        150, // Ukuran shimmer menyerupai ukuran elemen grid
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: miner.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          logger.d("JUMLAH MASONARY : ${listData.length}");
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return MasonryGridView.builder(
                            itemCount: listData.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final item = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalyticScreen(
                                              id: item.id.toString(),
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            "${ApiConstants.fotoDiagnosaPath}${item.file}",
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(height: 2.0),
                                      Text(
                                          '(${item.id}) ${item.diagnosa}, ${item.keakuratan}% Accuracy',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => MasonryGridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        150, // Ukuran shimmer menyerupai ukuran elemen grid
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: phoma.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          logger.d("JUMLAH MASONARY : ${listData.length}");
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return MasonryGridView.builder(
                            itemCount: listData.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final item = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalyticScreen(
                                              id: item.id.toString(),
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            "${ApiConstants.fotoDiagnosaPath}${item.file}",
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(height: 2.0),
                                      Text(
                                          '(${item.id}) ${item.diagnosa}, ${item.keakuratan}% Accuracy',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => MasonryGridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        150, // Ukuran shimmer menyerupai ukuran elemen grid
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: health.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          logger.d("JUMLAH MASONARY : ${listData.length}");
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return MasonryGridView.builder(
                            itemCount: listData.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final item = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalyticScreen(
                                              id: item.id.toString(),
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            "${ApiConstants.fotoDiagnosaPath}${item.file}",
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(height: 2.0),
                                      Text(
                                          '(${item.id}) ${item.diagnosa}, ${item.keakuratan}% Accuracy',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => MasonryGridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        150, // Ukuran shimmer menyerupai ukuran elemen grid
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: rust.when(
                      data: (data) {
                        if (data is SuccessListResponsePredict) {
                          final listData = data.data;
                          logger.d("JUMLAH MASONARY : ${listData.length}");
                          if (listData.isEmpty) {
                            return const Center(child: Text("Data Kosong!"));
                          }
                          return MasonryGridView.builder(
                            itemCount: listData.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final item = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalyticScreen(
                                              id: item.id.toString(),
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            "${ApiConstants.fotoDiagnosaPath}${item.file}",
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(height: 2.0),
                                      Text(
                                          '(${item.id}) ${item.diagnosa}, ${item.keakuratan}% Accuracy',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (data is ErrorResponsePredict) {
                          return Center(
                            child: Text(
                              'Gagal melakukan diagnosa',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => MasonryGridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        150, // Ukuran shimmer menyerupai ukuran elemen grid
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

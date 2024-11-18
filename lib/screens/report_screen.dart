import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/functions/snackbar_func.dart';
import 'package:iqacs/models/model_chart.dart';
import 'package:iqacs/providers/chart_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gap/gap.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = endDate.subtract(const Duration(days: 6));
  }

  void _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );

    if (picked != null) {
      if (picked.end.difference(picked.start).inDays > 7) {
        if (mounted) {
          showErrorSnackbar(
              context, 'Rentang tanggal tidak boleh lebih dari 7 hari!');
        }
      } else {
        setState(() {
          startDate = picked.start;
          endDate = picked.end;
        });
        ref.read(dateRangeProvider.notifier).updateDateRange(picked);
      }
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  List<String> _generateDateRange() {
    List<String> dateRange = [];
    DateTime current = startDate;

    while (current.isBefore(endDate.add(const Duration(days: 1)))) {
      dateRange.add(DateFormat('dd MMM').format(current));
      current = current.add(const Duration(days: 1));
    }
    return dateRange;
  }

  @override
  Widget build(BuildContext context) {
    final String formattedStartDate = _formatDate(startDate);
    final String formattedEndDate = _formatDate(endDate);
    final chartDataAsync = ref.watch(
      chartDataProvider(DateTimeRange(
        start: DateTime.parse(formattedStartDate),
        end: DateTime.parse(formattedEndDate),
      )),
    );

    List<String> xAxisDates = _generateDateRange();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(color: Color(0xFFF4F7FC)),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(149, 157, 165, 0.2),
                        offset: Offset(0, 8),
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      PopupMenuTheme(
                        data: const PopupMenuThemeData(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temperature & Humidity',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF171717),
                                    ),
                                  ),
                                  const Gap(8.0),
                                  Text(
                                    'Visualisasi data dari rata-rata\ntemperature dan humidity.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textWidthBasis: TextWidthBasis.parent,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const Gap(12.0),
                                  Text(
                                    'Filtered: ${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) {
                                  if (value == 'filter') {
                                    _pickDateRange();
                                  } else if (value == 'export') {}
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<String>(
                                      value: 'filter',
                                      child: Text('Filter'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'export',
                                      child: Text('Export'),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: chartDataAsync.when(
                          loading: () => ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: double.infinity,
                                height: 350,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          error: (error, stackTrace) {
                            if (error is DioException) {
                              debugPrint('DioException: ${error.message}');
                            } else {
                              debugPrint('Unexpected Error: $error');
                            }

                            return Center(
                              child: Text(
                                'Error: ${error.toString()}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          },
                          data: (ChartResponse chartData) {
                            final List<ChartData> data = chartData.data;
                            final List<FlSpot> humidityData = data
                                .map((e) => FlSpot(
                                      data.indexOf(e).toDouble(),
                                      e.avgHumidity,
                                    ))
                                .toList();
                            final List<FlSpot> temperatureData = data
                                .map((e) => FlSpot(
                                      data.indexOf(e).toDouble(),
                                      e.avgTemperature,
                                    ))
                                .toList();

                            return SizedBox(
                              height: 350,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    drawVerticalLine: false,
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        interval: 20,
                                        getTitlesWidget: (value, meta) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              '${value.toInt()}%',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF4C5BBB),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                        reservedSize: 40,
                                        interval: 20,
                                        getTitlesWidget: (value, meta) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              '${value.toInt()}C',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 32,
                                        interval: 1,
                                        getTitlesWidget: (value, meta) {
                                          int index = value.toInt();
                                          if (index >= 0 &&
                                              index < xAxisDates.length) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Text(
                                                xAxisDates[index],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFF171717),
                                                ),
                                              ),
                                            );
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  minY: 0,
                                  maxY: 100,
                                  minX: 0,
                                  maxX: xAxisDates.length.toDouble() - 1,
                                  lineBarsData: [
                                    LineChartBarData(
                                        spots: humidityData,
                                        isCurved: true,
                                        barWidth: 5,
                                        color: const Color(0xFF4C5BBB),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            stops: const [0.2, 0.5],
                                            colors: [
                                              const Color(0xFF4C5BBB)
                                                  .withOpacity(0.2),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        )),
                                    LineChartBarData(
                                      spots: temperatureData,
                                      isCurved: true,
                                      barWidth: 5,
                                      color: Colors.red,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          stops: const [0.2, 0.5],
                                          colors: [
                                            Colors.red.withOpacity(0.2),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ],
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Row(children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4C5BBB),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(8.0),
                              Text(
                                'Humidity',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF171717),
                                ),
                              ),
                            ]),
                            const Gap(20.0),
                            Row(children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(8.0),
                              Text(
                                'Temperature',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF171717),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Humidity Detail',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF171717),
                        ),
                      ),
                      const Gap(10.0),
                      chartDataAsync.when(
                        loading: () => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        error: (error, stackTrace) =>
                            Text('Error: ${error.toString()}'),
                        data: (ChartResponse chartData) {
                          return Column(
                            children: [
                              Column(
                                children: chartData.data.map<Widget>((data) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4C5BBB)
                                            .withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(data.tanggal))}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF4C5BBB),
                                                ),
                                              ),
                                              Text(
                                                'Precentase',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: DoughnutChart(
                                              totalValue: data.avgHumidity,
                                              isHumidity: true,
                                            ),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Temperature Detail',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF171717),
                        ),
                      ),
                      const Gap(10.0),
                      chartDataAsync.when(
                        loading: () => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        error: (error, stackTrace) =>
                            Text('Error: ${error.toString()}'),
                        data: (ChartResponse chartData) {
                          return Column(
                            children: [
                              Column(
                                children: chartData.data.map<Widget>((data) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(data.tanggal))}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                'Precentase',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: DoughnutChart(
                                              totalValue: data.avgTemperature,
                                            ),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
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

class DoughnutChart extends StatelessWidget {
  final double totalValue;
  final bool isHumidity;

  const DoughnutChart({
    super.key,
    required this.totalValue,
    this.isHumidity = false,
  });

  @override
  Widget build(BuildContext context) {
    final double total = totalValue;
    final double temperaturePercentage = 100 - total;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: total,
                  color: Colors.white,
                  title: '',
                  radius: 10,
                  titleStyle: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  titlePositionPercentageOffset: 1,
                ),
                PieChartSectionData(
                  value: temperaturePercentage,
                  color: Colors.transparent,
                  radius: 10,
                  title: '',
                ),
              ],
              centerSpaceRadius: 35,
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
            ),
          ),
          ClipOval(
            child: Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isHumidity ? const Color(0xFF4C5BBB) : Colors.red,
                    width: 8.0),
              ),
              child: Text(
                '${total.toStringAsFixed(1)}%',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

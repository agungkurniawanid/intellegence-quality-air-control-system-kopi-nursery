import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/functions/snackbar_func.dart';
import 'package:iqacs/models/model_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:excel/excel.dart' as esel;

final logger = Logger();

final chartDataProvider = StreamProvider.family<ChartResponse, DateTimeRange>(
  (ref, dateRange) async* {
    final dio = ref.watch(dioProviderConstant);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    final formattedStartDate = DateFormat('yyyy-MM-dd').format(dateRange.start);
    final formattedEndDate = DateFormat('yyyy-MM-dd').format(dateRange.end);

    try {
      await for (final _ in Stream.periodic(const Duration(seconds: 30))) {
        final response = await dio.get(
          '${ApiConstants.chartEndpoint}$formattedStartDate/$formattedEndDate',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) {
              return status != null &&
                  (status >= 200 && status < 300 || status == 302);
            },
          ),
        );

        if (response.statusCode == 200 &&
            response.data is Map<String, dynamic>) {
          yield ChartResponse.fromJson(response.data);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Failed to load chart data: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  },
);

final dateRangeProvider =
    StateNotifierProvider<DateRangeNotifier, DateTimeRange>((ref) {
  return DateRangeNotifier();
});

class DateRangeNotifier extends StateNotifier<DateTimeRange> {
  DateRangeNotifier() : super(_getInitialDateRange());

  static DateTimeRange _getInitialDateRange() {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 6));
    return DateTimeRange(start: startDate, end: endDate);
  }

  void updateDateRange(DateTimeRange newRange) {
    if (newRange.end.difference(newRange.start).inDays <= 7) {
      state = newRange;
    } else {
      throw Exception('Rentang tanggal tidak boleh lebih dari 7 hari');
    }
  }
}

Future<void> exportToExcel(ChartResponse chartData, context) async {
  // Membuat workbook baru
  var excel = esel.Excel.createExcel();
  esel.Sheet sheet = excel['Sheet1'];

  // Menambahkan header dengan gaya (opsional)
  esel.CellStyle cellStyle = esel.CellStyle(
    fontFamily: esel.getFontFamily(esel.FontFamily.Calibri),
    fontSize: 12,
    bold: true,
  );

  // Menambahkan header
  sheet.cell(esel.CellIndex.indexByString('A1')).value =
      esel.TextCellValue('Tanggal');
  sheet.cell(esel.CellIndex.indexByString('B1')).value =
      esel.TextCellValue('Rata-rata Suhu');
  sheet.cell(esel.CellIndex.indexByString('C1')).value =
      esel.TextCellValue('Rata-rata Kelembapan');

  // Mengatur gaya untuk header
  sheet.cell(esel.CellIndex.indexByString('A1')).cellStyle = cellStyle;
  sheet.cell(esel.CellIndex.indexByString('B1')).cellStyle = cellStyle;
  sheet.cell(esel.CellIndex.indexByString('C1')).cellStyle = cellStyle;

  // Menambahkan data dari chartData
  for (int i = 0; i < chartData.data.length; i++) {
    var data = chartData.data[i];
    int rowIndex = i + 2; // Mulai dari baris 2 untuk data
    sheet.cell(esel.CellIndex.indexByString('A$rowIndex')).value =
        esel.DateTimeCellValue(
      year: int.parse(data.tanggal.split('-')[0]),
      month: int.parse(data.tanggal.split('-')[1]),
      day: int.parse(data.tanggal.split('-')[2]),
      hour: 0,
      minute: 0,
    );
    sheet.cell(esel.CellIndex.indexByString('B$rowIndex')).value =
        esel.DoubleCellValue(data.avgTemperature);
    sheet.cell(esel.CellIndex.indexByString('C$rowIndex')).value =
        esel.DoubleCellValue(data.avgHumidity);
  }

  // Mendapatkan direktori Downloads
  String downloadsPath = 'storage/emulated/0/Download';
  Directory(downloadsPath).createSync(recursive: true);

  // Membuat nama file yang unik dengan menambahkan timestamp
  String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  String filePath = '$downloadsPath/chart_data_$timestamp.xlsx';

  // Menyimpan file Excel
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  showSuccessSnackbar(context, 'Berhasil disimpan di $filePath');
}

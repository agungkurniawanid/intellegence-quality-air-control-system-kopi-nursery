import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:iqacs/constants/api_constant.dart';
import 'package:iqacs/constants/dio_constant.dart';
import 'package:iqacs/models/model_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

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

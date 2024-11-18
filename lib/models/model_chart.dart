class ChartData {
  final String tanggal;
  final double avgTemperature;
  final double avgHumidity;

  ChartData({
    required this.tanggal,
    required this.avgTemperature,
    required this.avgHumidity,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      tanggal: json['tanggal'],
      avgTemperature: json['avg_temperature'].toDouble(),
      avgHumidity: json['avg_humidity'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'avg_temperature': avgTemperature,
      'avg_humidity': avgHumidity,
    };
  }
}

class ChartResponse {
  final List<ChartData> data;
  final String dariTanggal;
  final String sampaiTanggal;

  ChartResponse({
    required this.data,
    required this.dariTanggal,
    required this.sampaiTanggal,
  });

  factory ChartResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ChartData> chartDataList =
        list.map((i) => ChartData.fromJson(i)).toList();

    return ChartResponse(
      data: chartDataList,
      dariTanggal: json['dari_tanggal'],
      sampaiTanggal: json['sampai_tanggal'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> dataList = data.map((e) => e.toJson()).toList();

    return {
      'data': dataList,
      'dari_tanggal': dariTanggal,
      'sampai_tanggal': sampaiTanggal,
    };
  }
}

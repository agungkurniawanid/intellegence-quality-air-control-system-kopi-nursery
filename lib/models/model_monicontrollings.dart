class Monicontrolling {
  final int id;
  final int idAlat;
  final double nilaiHumidity;
  final double nilaiTemperature;
  final DateTime createdAt;
  final DateTime updatedAt;

  Monicontrolling({
    required this.id,
    required this.idAlat,
    required this.nilaiHumidity,
    required this.nilaiTemperature,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Monicontrolling.fromJson(Map<String, dynamic> json) {
    return Monicontrolling(
      id: json['id'],
      idAlat: json['id_alat'],
      nilaiHumidity: json['nilai_humidity'].toDouble(),
      nilaiTemperature: json['nilai_temperature'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_alat': idAlat,
      'nilai_humidity': nilaiHumidity,
      'nilai_temperature': nilaiTemperature,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ErrorResponsePredict {
  final String status;
  final String message;

  ErrorResponsePredict({required this.status, required this.message});

  factory ErrorResponsePredict.fromJson(Map<String, dynamic> json) {
    return ErrorResponsePredict(
      status: json['status'],
      message: json['message'],
    );
  }
}

class DataPredict {
  final int id;
  final int idUser;
  final String file;
  final String diagnosa;
  final String keakuratan;
  final String? deskripsi;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataPredict({
    required this.id,
    required this.idUser,
    required this.file,
    required this.diagnosa,
    required this.keakuratan,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataPredict.fromJson(Map<String, dynamic> json) {
    return DataPredict(
      id: json['id'],
      idUser: json['id_user'],
      file: json['file'],
      diagnosa: json['diagnosa'],
      keakuratan: json['keakuratan'],
      deskripsi: json['deskripsi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    return 'DataPredict(id: $id, idUser: $idUser, file: $file, diagnosa: $diagnosa, keakuratan: $keakuratan, deskripsi: $deskripsi, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class SuccessResponsePredict {
  final String status;
  final DataPredict data;

  SuccessResponsePredict({required this.status, required this.data});

  factory SuccessResponsePredict.fromJson(Map<String, dynamic> json) {
    return SuccessResponsePredict(
      status: json['status'],
      data: DataPredict.fromJson(json['data']),
    );
  }
}

class SuccessListResponsePredict {
  final String status;
  final List<DataPredict> data;

  SuccessListResponsePredict({required this.status, required this.data});

  factory SuccessListResponsePredict.fromJson(Map<String, dynamic> json) {
    return SuccessListResponsePredict(
      status: json['status'],
      data: (json['data'] as List).map((e) => DataPredict.fromJson(e)).toList(),
    );
  }
}

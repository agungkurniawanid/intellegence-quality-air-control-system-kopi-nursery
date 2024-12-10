class Diagnosa {
  final bool success;
  final Diagnosis? diagnosis;
  final String? message;

  Diagnosa({required this.success, this.diagnosis, this.message});

  factory Diagnosa.fromJson(Map<String, dynamic> json) {
    return Diagnosa(
      success: json['success'],
      diagnosis: json['diagnosa'] != null
          ? Diagnosis.fromJson(json['diagnosa'])
          : null,
      message: json['message'],
    );
  }
}

class Diagnosis {
  final String predictedClass;
  final String confidence;

  Diagnosis({required this.predictedClass, required this.confidence});

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      predictedClass: json['predicted_class'],
      confidence: json['confidence'],
    );
  }
}

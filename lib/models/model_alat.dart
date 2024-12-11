class StatusResponse {
  final String message;
  final bool pompaStatus;

  StatusResponse({required this.message, required this.pompaStatus});

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      message: json['message'] as String,
      // Mengonversi integer ke boolean
      pompaStatus: (json['pompa_status'] is int)
          ? (json['pompa_status'] == 1) // Jika 1, berarti true
          : json['pompa_status'] as bool, // Jika sudah boolean, ambil langsung
    );
  }
}

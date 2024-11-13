class StatusResponse {
  final String message;
  final bool pompaStatus;

  StatusResponse({required this.message, required this.pompaStatus});

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      message: json['message'] as String,
      pompaStatus: json['pompa_status'] as bool,
    );
  }
}

class UpdateProfile {
  final String status;
  final String message;

  UpdateProfile({required this.status, required this.message});

  factory UpdateProfile.fromJson(Map<String, dynamic> json) {
    return UpdateProfile(
      status: json['status'] ?? 'error',
      message: json['message'] ?? 'Unknown error occurred',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}

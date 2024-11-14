class ForgotPassword {
  final String status;
  final String message;

  ForgotPassword({required this.status, required this.message});

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(
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

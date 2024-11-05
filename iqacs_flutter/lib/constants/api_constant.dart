class ApiConstants {
  static const String baseUrl = 'http://192.168.1.23:8000/api/';
  static const String loginEndpoint = '$baseUrl/login';
  static const String logoutEndpoint = '$baseUrl/logout';

  // jika server tidak merespon dalam waktu 30 detik, maka koneksi dibatalkan
  static const Duration timeoutDuration = Duration(seconds: 30);
}

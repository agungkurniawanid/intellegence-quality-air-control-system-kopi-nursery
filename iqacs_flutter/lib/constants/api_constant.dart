class ApiConstants {
  // main url
  static const String baseUrl = 'http://192.168.1.11:8000';

  // endpoint
  static const String loginEndpoint = '$baseUrl/api/login';
  static const String logoutEndpoint = '$baseUrl/api/logout';
  static const String loginTokenEndpoint = '$baseUrl/api/check-token';
  static const String getDataTempHumidityEndpoint = '$baseUrl/api/getdataalat/';
  static const String fotoProfilPath = '/foto_profil/';

  // api external key
  static const String openWeatherApiKey = '89c748adb995fb8bc8afbe287c41ed51';

  // jika server tidak merespon dalam waktu 30 detik, maka koneksi dibatalkan
  static const Duration timeoutDuration = Duration(seconds: 30);
}

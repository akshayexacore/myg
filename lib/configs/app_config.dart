class AppConfig {
  // static const String baseUrl = 'https://13.232.65.165';
  // static const String imageBaseUrl = 'https://13.232.65.165/storage/app/';
  static const String baseUrl = 'https://claims.mygoal.biz';
  static const String imageBaseUrl = 'https://claims.mygoal.biz/storage/app/';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };static const Map<String, String> headersMultipart = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
}

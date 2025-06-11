class AppConfig {
  static const String baseUrl = 'https://13.232.65.165'; //live url
  static const String imageBaseUrl = 'https://13.232.65.165/storage/app/';

  // static const String baseUrl = 'http://43.205.38.30';                      //test url
  // static const String imageBaseUrl = 'http://43.205.38.30/storage/app/';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };static const Map<String, String> headersMultipart = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
}

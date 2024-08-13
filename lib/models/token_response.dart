import 'package:travel_claim/models/user.dart';

class TokenResponse {
  late bool success;
  late String message;
  late String refreshToken;
  late String accessToken;
  User? user;
  TokenResponse({this.success = false, this.message = '',this.accessToken = '',this.refreshToken = ''});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    if(json['token']!=null) {
      accessToken = json['token']['original']['access_token'] ?? '';
      refreshToken = json['random_string'] ?? '';
      if (json['token'] != null && json['token']['original']['user'] != null) {
        user = User.fromJson(json['token']['original']['user']);
      }
    }
  }
}
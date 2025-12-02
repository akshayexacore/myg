

import 'package:travel_claim/configs/api_constants.dart';
import 'package:travel_claim/models/token_response.dart';
import 'package:travel_claim/models/user.dart';
import 'package:travel_claim/utils/api_base_helper.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';

class AuthRepository {
  late final ApiBaseHelper _api = ApiBaseHelper();
  late final _preferences = SharedPreferencesDataProvider();

  Future<String> getAccessToken() async {
    return await _preferences.getAccessToken();
  }

  Future<void> saveAccessToken(String token) async {
    _preferences.saveAccessToken(token);
  }


  Future<void> saveIsGuestUser(bool guest) async {
    _preferences.saveIsGuestUser(guest);
  }

  Future<bool> getIsGuestUser() async {
   return await _preferences.getIsGuestUser();
  }


  Future<String> getRefreshToken() async {
    return await _preferences.getRefreshToken();
  }

  Future<void> saveRefreshToken(String token) async {
    _preferences.saveRefreshToken(token);
  }

  Future<bool> logoutUser() async {
    String refreshToken = await _preferences.getRefreshToken();
    await _api.post(ApiConstants.logout,headers: {},body: {'random_string':refreshToken});
    return true;
  }

  Future<TokenResponse> login(String username,String password) async {
    var body =  {
      "emp_id": username,
      "password": password
    };
    final response = await _api.post(ApiConstants.login,body: body,headers: {});
    return TokenResponse.fromJson(response);
  }

  Future<UserResponse> getUser() async {
    final response = await _api.get(ApiConstants.profile,headers: {});
    return UserResponse.fromJson(response);
  }

}

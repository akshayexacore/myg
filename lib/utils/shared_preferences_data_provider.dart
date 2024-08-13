import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataProvider {
  static const String token = 'authorization_token';
  static const String url = 'base_url';
  static const String refresh = 'refresh_token';
  static const String quality = 'quality';
  static const String userName = 'user_name';
  static const String userMobile = 'user_mobile';
  static const String userImage = 'user_image';
  static const String userMail = 'user_mail';
  static const String userDob = 'user_dob';
  static const String firebaseTokenSaved = 'firebase_token_saved';
  static const String userId = 'user_id';
  static const String isGuestUser = 'is_guest_user';


  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<bool> saveBaseUrl(String baseUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(url, baseUrl);
  }

  Future<String> getBaseUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(url) ?? '';
  }

  Future<bool> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(token, accessToken);
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(refresh, refreshToken);
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refresh) ?? '';
  }

  Future<bool> saveUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(userId, id);
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId) ?? 0;
  }

  Future<bool> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userName, name);
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  Future<bool> saveUserMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userMobile, mobile);
  }

  Future<String> getUserMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMobile) ?? '';
  }

  Future<bool> saveUserImage(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userImage, mobile);
  }

  Future<String> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage) ?? '';
  }

  Future<bool> saveUserMail(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userMail, mobile);
  }

  Future<String> getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMail) ?? '';
  }

  Future<bool> saveUserDob(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userDob, dob);
  }

  Future<String> getUserDob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDob) ?? '';
  }


  Future<bool> saveFirebaseTokenSaved(bool tokenSaved) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(firebaseTokenSaved, tokenSaved);
  }

  Future<bool> getFirebaseTokenSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firebaseTokenSaved) ?? false;
  }

  Future<bool> saveIsGuestUser(bool guest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isGuestUser, guest);
  }

  Future<bool> getIsGuestUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isGuestUser) ?? false;
  }

}

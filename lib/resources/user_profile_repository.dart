

import 'package:travel_claim/configs/api_constants.dart';
import 'package:travel_claim/models/post_response.dart';
import 'package:travel_claim/models/user.dart';
import 'package:travel_claim/utils/api_base_helper.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';

class UserProfileRepository {
  late final _preferences = SharedPreferencesDataProvider();
  late final _api = ApiBaseHelper();

  Future<User> getUserOffline() async {
    int id = await _preferences.getUserId();
    String name = await _preferences.getUserName();
    String mobile = await _preferences.getUserMobile();
    String image = await _preferences.getUserImage();
    String email = await _preferences.getUserMail();
    return User(
        id: id,
        profilePhoto: image,
        name: name,
        phoneNumber: mobile,
        email: email,);
  }

  Future<void> saveUser(User user) async {
    await _preferences.saveUserId(user.id);
    await _preferences.saveUserName(user.name);
    await _preferences.saveUserMobile(user.phoneNumber);
    await _preferences.saveUserImage(user.profilePhoto);
    await _preferences.saveUserMail(user.email);
  }

  Future<UserResponse> getUser() async {
    final response = await _api.get(ApiConstants.profile, headers: {});
    return UserResponse.fromJson(response);
  }

  Future<PostResponse> deleteAccount() async {
    final response = await _api.delete(ApiConstants.profile,header: {},);
    return PostResponse.fromJson(response);
  }
}

import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  static Dio dio = Dio();

  static Future<ProfileModel> getProfile() async {
    final response = await dio.get(
      "https://codingarabic.online/api/profile",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AppConstants.token}',
        },
      ),
    );
    return ProfileModel.fromJson(response.data['data']);
  }

  static Future<String> logout() async {
    try {
      await dio.post(
        "https://codingarabic.online/api/logout",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${AppConstants.token}',
          },
        ),
      );
      await _clearUserToken();
      AppConstants.token = null;
      return "success";
    } catch (e) {
      // Even if API call fails, clear local token
      await _clearUserToken();
      AppConstants.token = null;
      return "success";
    }
  }

  static Future<String> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final response = await dio.put(
        "https://codingarabic.online/api/update-profile",
        data: {
          "name": name,
          "email": email,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${AppConstants.token}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> _clearUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}

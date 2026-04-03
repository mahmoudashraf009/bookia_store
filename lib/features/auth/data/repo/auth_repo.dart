import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Dio dio = Dio();

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/login",
        data: {
          "email": email,
          "password": password, // ✅ شيل الـ : من password
        },
      );
      if (response.statusCode == 200) {
        saveUserToken(response.data["data"]["token"]);
        return "success";
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return e.toString();
    }
  }

  // ✅ أضف دالة register
  static Future<String> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      if (response.statusCode == 201) {
        saveUserToken(response.data["data"]["token"]);
        return "success";
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
}
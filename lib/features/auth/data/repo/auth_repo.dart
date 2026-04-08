import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/helper/app_constants.dart';

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
    await prefs.setString("token", token);
    AppConstants.token = token; // Synchronize global variable
  }

  static Future<String> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      final response = await dio.post(
        "https://codingarabic.online/api/logout",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        await prefs.remove("token");
        AppConstants.token = null;
        return "success";
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> sendForgetPasswordLink({required String email}) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/send-forget-password",
        data: {"email": email},
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

  static Future<String> checkForgetPasswordCode({required String code}) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/check-forget-password",
        data: {"code": code},
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

  static Future<String> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String code,
  }) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/reset-password",
        data: {
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "code": code,
        },
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

  static Future<String> resendVerifyLink({required String email}) async {
    try {
      final response = await dio.get(
        "https://codingarabic.online/api/resend-verify",
        data: {"email": email},
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

  static Future<String> verifyEmail({required String code}) async {
    try {
      final response = await dio.post(
        "https://codingarabic.online/api/verify-email",
        data: {"code": code},
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
}
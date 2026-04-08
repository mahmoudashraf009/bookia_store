import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  static Dio dio = Dio();

  static Options _authHeaders() {
    return Options(
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AppConstants.token}',
      },
    );
  }

  static Future<ProfileModel> getProfile() async {
    final response = await dio.get(
      "${AppConstants.baseUrl}/profile",
      options: _authHeaders(),
    );
    return ProfileModel.fromJson(response.data['data']);
  }

  static Future<String> logout() async {
    try {
      await dio.post(
        "${AppConstants.baseUrl}/logout",
        options: _authHeaders(),
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
        "${AppConstants.baseUrl}/update-profile",
        data: {
          "name": name,
          "email": email,
        },
        options: _authHeaders(),
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

  static Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.post(
        "${AppConstants.baseUrl}/update-password",
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
        options: _authHeaders(),
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception("Something went wrong");
      }
    } on DioException catch (e) {
      // DEBUG: Print full response to console
      debugPrint('=== UPDATE PASSWORD ERROR ===');
      debugPrint('Status: ${e.response?.statusCode}');
      debugPrint('Full Response: ${e.response?.data}');
      debugPrint('============================');

      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map) {
          // Collect all error messages
          List<String> errorMessages = [];

          // Check "error" field (this API format: {error: [...], message: "..."})
          if (data.containsKey('error')) {
            final error = data['error'];
            if (error is Map) {
              // Laravel errors format: {error: {field: [msg1, msg2]}}
              for (var messages in error.values) {
                if (messages is List) {
                  for (var msg in messages) {
                    errorMessages.add(msg.toString());
                  }
                }
              }
            } else if (error is List && error.isNotEmpty) {
              for (var msg in error) {
                if (msg is String && msg.isNotEmpty) {
                  errorMessages.add(msg);
                }
              }
            } else if (error is String && error.isNotEmpty) {
              errorMessages.add(error);
            }
          }

          // Check "errors" field (standard Laravel validation)
          if (data.containsKey('errors') && data['errors'] is Map) {
            final errors = data['errors'] as Map;
            for (var messages in errors.values) {
              if (messages is List) {
                for (var msg in messages) {
                  errorMessages.add(msg.toString());
                }
              }
            }
          }

          // Return collected errors or fallback to message
          if (errorMessages.isNotEmpty) {
            return errorMessages.join('\n');
          }

          // Fallback: return the message field
          if (data.containsKey('message') && data['message'] != null) {
            return data['message'].toString();
          }
        }
      }
      return "Failed to update password (${e.response?.statusCode})";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> _clearUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}

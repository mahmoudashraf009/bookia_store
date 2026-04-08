import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';

class ContactRepo {
  static Dio dio = Dio();

  static Future<Response> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    return await dio.post(
      '${AppConstants.baseUrl}/contact',
      data: {
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
      },
      options: Options(headers: {
        'Accept': 'application/json',
      }),
    );
  }
}

import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';

class FaqRepo {
  static Dio dio = Dio();

  static Future<Response> getFaqs() async {
    return await dio.get(
      '${AppConstants.baseUrl}/faqs',
      options: Options(headers: {
        'Accept': 'application/json',
      }),
    );
  }
}

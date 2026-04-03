import 'package:dio/dio.dart';
import 'package:bookia_store/core/helper/app_constants.dart';

void main() async {
  final dio = Dio();
  // We need the token. I don't have the token in the script, so maybe we get 401. 
  // Let's at least see if it gives 401 or 404 for the endpoints.
  final endpoints = ['/api/wishlist', '/api/cart', '/api/profile'];
  for (var ep in endpoints) {
    try {
      final res = await dio.get(
        'https://codingarabic.online\$ep',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      print('GET \$ep -> \${res.statusCode}');
    } on DioException catch (e) {
      if (e.response != null) {
        print('GET \$ep -> \${e.response?.statusCode}');
      } else {
        print('GET \$ep -> Error: \${e.message}');
      }
    }
  }
}

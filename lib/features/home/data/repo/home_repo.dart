import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';
import '../models/book_model.dart';

class HomeRepo {
  final Dio dio;

  HomeRepo(this.dio);

  Future<List<BookModel>> getBestSeller() async {
    final response = await dio.get(
      'https://codingarabic.online/api/products',
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (AppConstants.token != null)
            'Authorization': 'Bearer ${AppConstants.token}',
        },
      ),
    );
    final List data = response.data['data']['products'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<List<String>> getSliders() async {
    try {
      final response = await dio.get(
        'https://codingarabic.online/api/sliders',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      final List data = response.data['data']['sliders'];
      return data.map((e) => e['image'].toString()).toList();
    } catch (e) {
      return [];
    }
  }
}

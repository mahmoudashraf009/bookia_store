import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';
import '../models/book_model.dart';

class HomeRepo {
  final Dio dio;

  HomeRepo(this.dio);

  Options _headers() {
    return Options(
      headers: {
        'Accept': 'application/json',
        if (AppConstants.token != null)
          'Authorization': 'Bearer ${AppConstants.token}',
      },
    );
  }

  Future<List<BookModel>> getBestSeller() async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/products',
      options: _headers(),
    );
    final List data = response.data['data']['products'] ?? [];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<List<String>> getSliders() async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/sliders',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final List data = response.data['data']['sliders'] ?? [];
      return data.map((e) => e['image'].toString()).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<BookModel>> getNewArrivals() async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/products-new-arrivals',
        options: _headers(),
      );
      final List data = response.data['data']['products'] ?? [];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<BookModel>> searchProducts(String query) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/products-search',
      data: {'name': query},
      options: _headers(),
    );
    final List data = response.data['data']['products'] ?? response.data['data'] ?? [];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<List<BookModel>> filterProducts({String? category}) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/products-filter',
      data: {
        if (category != null) 'category': category,
      },
      options: _headers(),
    );
    final List data = response.data['data']['products'] ?? response.data['data'] ?? [];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<BookModel> showProduct(int productId) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/products/$productId',
      options: _headers(),
    );
    return BookModel.fromJson(response.data['data']);
  }
}

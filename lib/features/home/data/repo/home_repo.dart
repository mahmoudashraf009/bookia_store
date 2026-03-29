import 'package:dio/dio.dart';
import '../models/book_model.dart';

class HomeRepo {
  final Dio dio;

  HomeRepo(this.dio);

  Future<List<BookModel>> getBestSeller() async {
    final response = await dio.get(
      'https://codingarabic.online/api/best-seller',
    );
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }
}
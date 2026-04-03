import 'package:bookia_store/features/home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final repo = HomeRepo(dio);
    final books = await repo.getBestSeller();
    print('Fetched ${books.length} books');
  } catch (e) {
    print('Error fetching best sellers: $e');
  }
}

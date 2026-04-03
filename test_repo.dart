import 'package:bookia_store/features/home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final repo = HomeRepo(dio);
    final sliders = await repo.getSliders();
    print('Returned sliders: $sliders');
  } catch (e) {
    print('Error: $e');
  }
}

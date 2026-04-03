import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    final response = await dio.get(
      'https://codingarabic.online/api/sliders',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    dynamic respData = response.data;
    print('Type of response.data: ${respData.runtimeType}');
    
    if (respData is String) {
      print('Is String');
    } else {
      print('Is map');
      final data = respData['data'];
      print('Type of data: ${data.runtimeType}');
      final sliders = data['sliders'];
      print('Type of sliders: ${sliders.runtimeType}');
      List listSliders = sliders;
      print('Length of listSliders: ${listSliders.length}');
      final strList = listSliders.map((e) => e['image'].toString()).toList();
      print('Mapped: $strList');
    }
  } catch (e) {
    print('Error: $e');
  }
}

import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(
    validateStatus: (status) => true,
    headers: {
      'Accept': 'application/json',
    }
  ));
  
  print('1. Registering a test user...');
  final email = 'test_bookia_${DateTime.now().millisecondsSinceEpoch}@example.com';
  final password = 'password123';
  
  final registerRes = await dio.post(
    'https://codingarabic.online/api/register',
    data: {
      'name': 'Test User',
      'email': email,
      'password': password,
      'password_confirmation': password,
    }
  );
  
  if (registerRes.statusCode != 201 && registerRes.statusCode != 200) {
    print('Failed to register: ${registerRes.statusCode} - ${registerRes.data}');
    return;
  }
  
  final token = registerRes.data['data']['token'];
  print('Got token: $token');
  
  dio.options.headers['Authorization'] = 'Bearer $token';
  
  print('\n2. Testing update-password with wrong current password...');
  final test1 = await dio.post(
    'https://codingarabic.online/api/update-password',
    data: {
      'current_password': 'wrongpassword',
      'password': 'newpassword123',
      'password_confirmation': 'newpassword123',
    }
  );
  print('Status: ${test1.statusCode}');
  print('Response: ${test1.data}');
  
  print('\n3. Testing update-password with old_password (another common name)...');
  final test2 = await dio.post(
    'https://codingarabic.online/api/update-password',
    data: {
      'old_password': 'wrongpassword',
      'password': 'newpassword123',
      'password_confirmation': 'newpassword123',
    }
  );
  print('Status: ${test2.statusCode}');
  print('Response: ${test2.data}');

  print('\n4. Testing update-password with new_password...');
  final test3 = await dio.post(
    'https://codingarabic.online/api/update-password',
    data: {
      'current_password': 'wrongpassword',
      'new_password': 'newpassword123',
      'new_password_confirmation': 'newpassword123',
    }
  );
  print('Status: ${test3.statusCode}');
  print('Response: ${test3.data}');
}

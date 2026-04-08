import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';

class OrderRepo {
  static Dio dio = Dio();

  static Options _authHeaders() {
    return Options(headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstants.token}',
    });
  }

  static Future<Response> checkout() async {
    return await dio.get(
      '${AppConstants.baseUrl}/checkout',
      options: _authHeaders(),
    );
  }

  static Future<Response> placeOrder({
    required String name,
    required String email,
    required String phone,
    required String address,
    required int governorateId,
  }) async {
    return await dio.post(
      '${AppConstants.baseUrl}/place-order',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'governorate_id': governorateId,
      },
      options: _authHeaders(),
    );
  }

  static Future<Response> getOrderHistory() async {
    return await dio.get(
      '${AppConstants.baseUrl}/order-history',
      options: _authHeaders(),
    );
  }

  static Future<Response> showSingleOrder(int orderId) async {
    return await dio.get(
      '${AppConstants.baseUrl}/order/$orderId',
      options: _authHeaders(),
    );
  }

  static Future<Response> getGovernorates() async {
    return await dio.get(
      '${AppConstants.baseUrl}/governorates',
      options: Options(headers: {'Accept': 'application/json'}),
    );
  }
}

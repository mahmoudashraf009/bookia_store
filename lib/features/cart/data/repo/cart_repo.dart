import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:dio/dio.dart';

class CartRepo {
  final Dio dio;

  CartRepo(this.dio);

  Future<Response> showCart() async {
    return await dio.get(
      '${AppConstants.baseUrl}/cart',
      options: Options(headers: {
        'Authorization': 'Bearer ${AppConstants.token}',
      }),
    );
  }

  Future<Response> addToCart(int bookId) async {
    return await dio.post(
      '${AppConstants.baseUrl}/add-to-cart',
      data: {
        'product_id': bookId, // Please check if Postman uses 'book_id' or 'product_id'
      },
      options: Options(headers: {
        'Authorization': 'Bearer ${AppConstants.token}',
      }),
    );
  }

  Future<Response> updateCart(int cartItemId, int quantity) async {
    return await dio.post(
      '${AppConstants.baseUrl}/update-cart',
      data: {
        'cart_item_id': cartItemId,
        'quantity': quantity,
      },
      options: Options(headers: {
        'Authorization': 'Bearer ${AppConstants.token}',
      }),
    );
  }

  Future<Response> removeFromCart(int cartItemId) async {
    return await dio.post(
      '${AppConstants.baseUrl}/remove-from-cart',
      data: {
        'cart_item_id': cartItemId,
      },
      options: Options(headers: {
        'Authorization': 'Bearer ${AppConstants.token}',
      }),
    );
  }
}

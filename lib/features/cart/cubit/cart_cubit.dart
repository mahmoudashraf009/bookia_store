import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/cart_item_model.dart';
import '../data/repo/cart_repo.dart';
import '../../../core/helper/dio_helper.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  List<CartItemModel> cartItems = [];
  double totalPrice = 0.0;

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final response = await cartRepo.showCart();
      if (response.statusCode == 200) {
        // Parse items. This logic depends on exact JSON format, 
        // falling back to a generic parsing array from "data" mapping.
        final List<dynamic>? data = response.data['data']['cart_items'] ?? response.data['data'];
        
        if (data != null) {
          cartItems = data.map((json) => CartItemModel.fromJson(json)).toList();
        } else {
          cartItems = [];
        }

        // Try to read total price from backend or calculate it locally via loop
        totalPrice = double.tryParse(response.data['data']['total'].toString()) ?? 
                     cartItems.fold(0.0, (sum, item) => sum + item.total);

        emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
      } else {
        emit(CartError(message: "Failed to load cart"));
      }
    } catch (e) {
      emit(CartError(message: DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> addToCart(int bookId) async {
    emit(AddToCartLoading());
    try {
      final response = await cartRepo.addToCart(bookId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddToCartSuccess());
        // Refresh cart to show the new item
        await getCart();
      } else {
        emit(AddToCartError(message: "Failed to add to cart"));
      }
    } catch (e) {
      emit(AddToCartError(message: DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> updateCart(int cartItemId, int quantity) async {
    emit(UpdateCartLoading());
    try {
      final response = await cartRepo.updateCart(cartItemId, quantity);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateCartSuccess());
        await getCart();
      } else {
        emit(UpdateCartError(message: "Failed to update cart"));
      }
    } catch (e) {
      emit(UpdateCartError(message: DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    emit(RemoveFromCartLoading());
    try {
      final response = await cartRepo.removeFromCart(cartItemId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RemoveFromCartSuccess());
        await getCart();
      } else {
        emit(RemoveFromCartError(message: "Failed to remove from cart"));
      }
    } catch (e) {
      emit(RemoveFromCartError(message: DioHelper.getErrorMessage(e)));
    }
  }
}

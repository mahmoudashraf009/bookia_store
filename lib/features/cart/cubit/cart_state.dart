part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double totalPrice;

  CartLoaded({required this.cartItems, required this.totalPrice});
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}

class AddToCartLoading extends CartState {}
class AddToCartSuccess extends CartState {}
class AddToCartError extends CartState {
  final String message;
  AddToCartError({required this.message});
}

class RemoveFromCartLoading extends CartState {}
class RemoveFromCartSuccess extends CartState {}
class RemoveFromCartError extends CartState {
  final String message;
  RemoveFromCartError({required this.message});
}

class UpdateCartLoading extends CartState {}
class UpdateCartSuccess extends CartState {}
class UpdateCartError extends CartState {
  final String message;
  UpdateCartError({required this.message});
}

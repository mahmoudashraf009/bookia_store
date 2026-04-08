part of 'order_cubit.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

// Governorates
class GetGovernoratesLoading extends OrderState {}
class GetGovernoratesSuccess extends OrderState {}
class GetGovernoratesError extends OrderState {
  final String message;
  GetGovernoratesError(this.message);
}

// Checkout
class CheckoutLoading extends OrderState {}
class CheckoutSuccess extends OrderState {
  final dynamic data;
  CheckoutSuccess(this.data);
}
class CheckoutError extends OrderState {
  final String message;
  CheckoutError(this.message);
}

// Place Order
class PlaceOrderLoading extends OrderState {}
class PlaceOrderSuccess extends OrderState {}
class PlaceOrderError extends OrderState {
  final String message;
  PlaceOrderError(this.message);
}

// Order History
class OrderHistoryLoading extends OrderState {}
class OrderHistorySuccess extends OrderState {}
class OrderHistoryError extends OrderState {
  final String message;
  OrderHistoryError(this.message);
}

// Show Single Order
class ShowSingleOrderLoading extends OrderState {}
class ShowSingleOrderSuccess extends OrderState {
  final OrderModel order;
  ShowSingleOrderSuccess(this.order);
}
class ShowSingleOrderError extends OrderState {
  final String message;
  ShowSingleOrderError(this.message);
}

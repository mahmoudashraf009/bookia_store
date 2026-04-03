import '../data/models/book_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

// Get Best Seller
class GetBestSellerLoading extends HomeState {}

class GetBestSellerSuccess extends HomeState {}

class GetBestSellerError extends HomeState {
  final String message;
  GetBestSellerError(this.message);
}

// Get Sliders
class GetSlidersLoading extends HomeState {}

class GetSlidersSuccess extends HomeState {}

class GetSlidersError extends HomeState {
  final String message;
  GetSlidersError(this.message);
}

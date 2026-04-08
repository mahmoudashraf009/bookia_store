
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

// Get New Arrivals
class GetNewArrivalsLoading extends HomeState {}

class GetNewArrivalsSuccess extends HomeState {}

class GetNewArrivalsError extends HomeState {
  final String message;
  GetNewArrivalsError(this.message);
}

// Search
class SearchLoading extends HomeState {}

class SearchSuccess extends HomeState {}

class SearchError extends HomeState {
  final String message;
  SearchError(this.message);
}

class SearchCleared extends HomeState {}
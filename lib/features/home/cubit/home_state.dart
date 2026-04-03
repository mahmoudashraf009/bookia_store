import '../data/models/book_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<BookModel> books;
  final List<String> sliders;
  HomeSuccess(this.books, {this.sliders = const []});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
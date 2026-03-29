import '../data/models/book_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<BookModel> books;
  HomeSuccess(this.books);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
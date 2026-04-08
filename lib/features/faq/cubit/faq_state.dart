part of 'faq_cubit.dart';

abstract class FaqState {}

class FaqInitial extends FaqState {}
class FaqLoading extends FaqState {}
class FaqSuccess extends FaqState {}
class FaqError extends FaqState {
  final String message;
  FaqError(this.message);
}

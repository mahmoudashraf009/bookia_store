import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/book_model.dart';
import '../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> getBestSeller() async {
    emit(HomeLoading());
    try {
      final books = await homeRepo.getBestSeller();
      emit(HomeSuccess(books));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
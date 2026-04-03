import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/home_repo.dart';
import 'home_state.dart';
import '../data/models/book_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  List<BookModel> bestSellerBooks = [];
  List<String> sliders = [];

  Future<void> getBestSeller() async {
    emit(GetBestSellerLoading());
    try {
      bestSellerBooks = await homeRepo.getBestSeller();
      emit(GetBestSellerSuccess());
    } catch (e) {
      emit(GetBestSellerError(e.toString()));
    }
  }

  Future<void> getSliders() async {
    emit(GetSlidersLoading());
    try {
      sliders = await homeRepo.getSliders();
      emit(GetSlidersSuccess());
    } catch (e) {
      emit(GetSlidersError(e.toString()));
    }
  }
}

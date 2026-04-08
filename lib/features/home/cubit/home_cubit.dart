import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/home_repo.dart';
import 'home_state.dart';
import '../data/models/book_model.dart';
import '../../../core/helper/dio_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  List<BookModel> bestSellerBooks = [];
  List<BookModel> newArrivalBooks = [];
  List<BookModel> searchResults = [];
  List<String> sliders = [];

  Future<void> getBestSeller() async {
    emit(GetBestSellerLoading());
    try {
      bestSellerBooks = await homeRepo.getBestSeller();
      emit(GetBestSellerSuccess());
    } catch (e) {
      emit(GetBestSellerError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> getSliders() async {
    emit(GetSlidersLoading());
    try {
      sliders = await homeRepo.getSliders();
      emit(GetSlidersSuccess());
    } catch (e) {
      emit(GetSlidersError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> getNewArrivals() async {
    emit(GetNewArrivalsLoading());
    try {
      newArrivalBooks = await homeRepo.getNewArrivals();
      emit(GetNewArrivalsSuccess());
    } catch (e) {
      emit(GetNewArrivalsError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(SearchLoading());
    try {
      searchResults = await homeRepo.searchProducts(query);
      emit(SearchSuccess());
    } catch (e) {
      emit(SearchError(DioHelper.getErrorMessage(e)));
    }
  }

  void clearSearch() {
    searchResults = [];
    emit(SearchCleared());
  }
}
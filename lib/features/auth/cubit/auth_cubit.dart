import 'package:bloc/bloc.dart';
import 'package:bookia_store/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.login(email: email, password: password);
    if (response == "success") {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (response == "success") {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
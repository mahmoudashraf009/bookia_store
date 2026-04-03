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

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final response = await AuthRepo.logout();
    if (response == "success") {
      emit(LogoutSuccessState());
    } else {
      emit(LogoutErrorState());
    }
  }

  Future<void> sendForgetPasswordLink({required String email}) async {
    emit(SendForgetPasswordLinkLoadingState());
    final response = await AuthRepo.sendForgetPasswordLink(email: email);
    if (response == "success") {
      emit(SendForgetPasswordLinkSuccessState());
    } else {
      emit(SendForgetPasswordLinkErrorState());
    }
  }

  Future<void> checkForgetPasswordCode({required String code}) async {
    emit(CheckForgetPasswordCodeLoadingState());
    final response = await AuthRepo.checkForgetPasswordCode(code: code);
    if (response == "success") {
      emit(CheckForgetPasswordCodeSuccessState());
    } else {
      emit(CheckForgetPasswordCodeErrorState());
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String code,
  }) async {
    emit(ResetPasswordLoadingState());
    final response = await AuthRepo.resetPassword(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      code: code,
    );
    if (response == "success") {
      emit(ResetPasswordSuccessState());
    } else {
      emit(ResetPasswordErrorState());
    }
  }

  Future<void> resendVerifyLink({required String email}) async {
    emit(ResendVerifyLinkLoadingState());
    final response = await AuthRepo.resendVerifyLink(email: email);
    if (response == "success") {
      emit(ResendVerifyLinkSuccessState());
    } else {
      emit(ResendVerifyLinkErrorState());
    }
  }

  Future<void> verifyEmail({required String code}) async {
    emit(VerifyEmailLoadingState());
    final response = await AuthRepo.verifyEmail(code: code);
    if (response == "success") {
      emit(VerifyEmailSuccessState());
    } else {
      emit(VerifyEmailErrorState());
    }
  }
}
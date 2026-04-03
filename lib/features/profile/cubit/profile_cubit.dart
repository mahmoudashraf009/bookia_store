import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await ProfileRepo.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      final result = await ProfileRepo.logout();
      if (result == "success") {
        emit(LogoutSuccess());
      } else {
        emit(LogoutError("Logout failed"));
      }
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    emit(UpdateProfileLoading());
    try {
      final result = await ProfileRepo.updateProfile(
        name: name,
        email: email,
      );
      if (result == "success") {
        emit(UpdateProfileSuccess());
        // Reload profile after update
        getProfile();
      } else {
        emit(UpdateProfileError(result));
      }
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}

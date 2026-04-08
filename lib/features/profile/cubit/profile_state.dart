import '../data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class LogoutLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}

class LogoutError extends ProfileState {
  final String message;
  LogoutError(this.message);
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError(this.message);
}

class UpdatePasswordLoading extends ProfileState {}

class UpdatePasswordSuccess extends ProfileState {}

class UpdatePasswordError extends ProfileState {
  final String message;
  UpdatePasswordError(this.message);
}

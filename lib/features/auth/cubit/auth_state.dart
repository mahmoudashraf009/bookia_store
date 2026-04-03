part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccessState extends AuthState {}
final class AuthErrorState extends AuthState {}
final class AuthLoadingState extends AuthState {}

// Logout
final class LogoutLoadingState extends AuthState {}
final class LogoutSuccessState extends AuthState {}
final class LogoutErrorState extends AuthState {}

// Send Forget Password Link
final class SendForgetPasswordLinkLoadingState extends AuthState {}
final class SendForgetPasswordLinkSuccessState extends AuthState {}
final class SendForgetPasswordLinkErrorState extends AuthState {}

// Check Forget Password Code
final class CheckForgetPasswordCodeLoadingState extends AuthState {}
final class CheckForgetPasswordCodeSuccessState extends AuthState {}
final class CheckForgetPasswordCodeErrorState extends AuthState {}

// Reset Password
final class ResetPasswordLoadingState extends AuthState {}
final class ResetPasswordSuccessState extends AuthState {}
final class ResetPasswordErrorState extends AuthState {}

// Resend Verify Link
final class ResendVerifyLinkLoadingState extends AuthState {}
final class ResendVerifyLinkSuccessState extends AuthState {}
final class ResendVerifyLinkErrorState extends AuthState {}

// Verify Email
final class VerifyEmailLoadingState extends AuthState {}
final class VerifyEmailSuccessState extends AuthState {}
final class VerifyEmailErrorState extends AuthState {}

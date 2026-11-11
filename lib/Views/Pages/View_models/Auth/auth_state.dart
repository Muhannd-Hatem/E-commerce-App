part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

final class AuthDone extends AuthState {
  AuthDone();
}

final class AuthLoggedOut extends AuthState {
  AuthLoggedOut();
}

final class AuthLoggingOut extends AuthState {
  AuthLoggingOut();
}

final class AuthLoggingOutError extends AuthState {
  final String message;
  AuthLoggingOutError({required this.message});
}

final class GoogleAuthenticating extends AuthState {}

final class GoogleAuthenticationDone extends AuthState {}

final class GoogleAuthenticationError extends AuthState {
  final String message;
  GoogleAuthenticationError({required this.message});
}

final class FacebookAuthenticating extends AuthState {}

final class FacebookAuthenticationDone extends AuthState {}

final class FacebookAuthenticationError extends AuthState {
  final String message;
  FacebookAuthenticationError({required this.message});
}

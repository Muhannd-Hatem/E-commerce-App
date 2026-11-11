part of 'password_visibility_cubit.dart';

sealed class PasswordVisibilityState {
  final bool isHidden;
  const PasswordVisibilityState(this.isHidden);
}

final class PasswordVisibilityInitial extends PasswordVisibilityState {
  // القيمة الابتدائية تكون true (كلمة المرور مخفية)
  const PasswordVisibilityInitial() : super(true);
}

final class PasswordVisibilityUpdated extends PasswordVisibilityState {
  const PasswordVisibilityUpdated({required bool isHidden}) : super(isHidden);
}

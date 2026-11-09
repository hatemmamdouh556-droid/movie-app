part of 'register_cubit.dart';

class RegisterState {
  const RegisterState({
    this.status = RegisterStatus.idle,
    this.user,
    this.failure,
  });

  final RegisterStatus status;
  final AppUser? user;
  final AuthFailure? failure;

  bool get isSubmitting => status == RegisterStatus.submitting;

  bool get isSuccess => status == RegisterStatus.success;

  bool get hasFailed => status == RegisterStatus.failure;
}

/// Handles the registration form. The screen owns the field validation; the
/// cubit creates the account, the display name and the verification email.

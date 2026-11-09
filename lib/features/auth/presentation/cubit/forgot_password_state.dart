part of 'forgot_password_cubit.dart';

class ForgotPasswordState {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.idle,
    this.failure,
  });

  final ForgotPasswordStatus status;
  final AuthFailure? failure;

  bool get isSubmitting => status == ForgotPasswordStatus.submitting;

  bool get isSuccess => status == ForgotPasswordStatus.success;

  bool get hasFailed => status == ForgotPasswordStatus.failure;
}

/// Sends the password reset email.
///
/// The success message is intentionally neutral: it is shown whether or not an
/// account exists for the given email address.

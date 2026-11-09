part of 'new_password_cubit.dart';

class NewPasswordState {
  const NewPasswordState({
    this.status = NewPasswordStatus.verifying,
    this.email,
    this.failure,
  });

  final NewPasswordStatus status;

  /// Email extracted from the reset code, available once the link is valid.
  final String? email;

  final AuthFailure? failure;

  bool get isVerifying => status == NewPasswordStatus.verifying;

  bool get isReady => status == NewPasswordStatus.ready;

  bool get isSubmitting => status == NewPasswordStatus.submitting;

  bool get isSuccess => status == NewPasswordStatus.success;

  /// The code was rejected by the provider (expired, used or malformed).
  bool get hasInvalidLink => status == NewPasswordStatus.invalidLink;

  /// Saving the new password failed, but the form can be retried.
  bool get hasFailed => status == NewPasswordStatus.failure;
}

/// Verifies a Firebase password reset code and saves the new password.

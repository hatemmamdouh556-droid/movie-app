part of 'email_verification_cubit.dart';

class EmailVerificationState {
  const EmailVerificationState({
    this.status = EmailVerificationStatus.idle,
    this.failure,
    this.cooldownSeconds = 0,
  });

  final EmailVerificationStatus status;
  final AuthFailure? failure;
  final int cooldownSeconds;

  bool get isSending => status == EmailVerificationStatus.sending;

  bool get canResend => !isSending && cooldownSeconds == 0;

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
    AuthFailure? failure,
    bool clearFailure = false,
    int? cooldownSeconds,
  }) => EmailVerificationState(
    status: status ?? this.status,
    failure: clearFailure ? null : (failure ?? this.failure),
    cooldownSeconds: cooldownSeconds ?? this.cooldownSeconds,
  );
}

/// Handles (re)sending the verification email.
///
/// A cooldown is applied after every attempt so the user cannot spam the
/// provider and hit its rate limit.

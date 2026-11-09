import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';

part 'email_verification_status.dart';
part 'email_verification_state.dart';

/// Status of the verification email request.

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this._service) : super(const EmailVerificationState());

  static const int resendCooldownSeconds = 60;

  final AuthService _service;
  Timer? _cooldownTimer;

  Future<void> resendEmail() async {
    if (!state.canResend) return;
    emit(
      state.copyWith(
        status: EmailVerificationStatus.sending,
        clearFailure: true,
      ),
    );
    try {
      await _service.sendEmailVerification();
      emit(state.copyWith(status: EmailVerificationStatus.sent));
      _startCooldown();
    } on AuthFailure catch (failure) {
      emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          failure: failure,
        ),
      );
      if (failure.type == AuthFailureType.tooManyRequests) _startCooldown();
    }
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _emitCooldown(resendCooldownSeconds);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.cooldownSeconds - 1;
      if (remaining <= 0) {
        timer.cancel();
        _emitCooldown(0);
      } else {
        _emitCooldown(remaining);
      }
    });
  }

  void _emitCooldown(int seconds) =>
      emit(state.copyWith(cooldownSeconds: seconds));

  @override
  Future<void> close() async {
    _cooldownTimer?.cancel();
    return super.close();
  }
}

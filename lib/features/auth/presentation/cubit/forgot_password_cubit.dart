import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';

part 'forgot_password_status.dart';
part 'forgot_password_state.dart';

/// Status of the "forgot password" form.

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._service) : super(const ForgotPasswordState());

  final AuthService _service;

  Future<void> submit(String email) async {
    if (state.isSubmitting) return;
    emit(const ForgotPasswordState(status: ForgotPasswordStatus.submitting));
    try {
      await _service.sendPasswordResetEmail(email);
      emit(const ForgotPasswordState(status: ForgotPasswordStatus.success));
    } on AuthFailure catch (failure) {
      emit(
        ForgotPasswordState(
          status: ForgotPasswordStatus.failure,
          failure: failure,
        ),
      );
    }
  }

  /// Clears a previous result when the user edits the email.
  void clearResult() {
    if (state.status == ForgotPasswordStatus.idle) return;
    emit(const ForgotPasswordState());
  }
}

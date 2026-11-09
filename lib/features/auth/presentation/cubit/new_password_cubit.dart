import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';

part 'new_password_status.dart';
part 'new_password_state.dart';

/// Status of the "set a new password" screen.

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this._service, this.code) : super(const NewPasswordState()) {
    _verifyCode();
  }

  final AuthService _service;
  final String code;

  Future<void> _verifyCode() async {
    if (code.trim().isEmpty) {
      emit(
        const NewPasswordState(
          status: NewPasswordStatus.invalidLink,
          failure: AuthFailure(AuthFailureType.invalidActionCode),
        ),
      );
      return;
    }
    try {
      final email = await _service.verifyPasswordResetCode(code);
      emit(NewPasswordState(status: NewPasswordStatus.ready, email: email));
    } on AuthFailure catch (failure) {
      emit(
        NewPasswordState(
          status: NewPasswordStatus.invalidLink,
          failure: failure,
        ),
      );
    }
  }

  Future<void> submit(String newPassword) async {
    if (!state.isReady) return;
    emit(
      NewPasswordState(
        status: NewPasswordStatus.submitting,
        email: state.email,
      ),
    );
    try {
      await _service.confirmPasswordReset(code: code, newPassword: newPassword);
      emit(
        NewPasswordState(status: NewPasswordStatus.success, email: state.email),
      );
    } on AuthFailure catch (failure) {
      emit(
        NewPasswordState(
          status: NewPasswordStatus.failure,
          email: state.email,
          failure: failure,
        ),
      );
    }
  }
}

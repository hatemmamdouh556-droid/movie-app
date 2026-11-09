import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';
import 'package:movies_app/features/auth/domain/auth_user.dart';

part 'login_status.dart';
part 'login_state.dart';

/// Status of the login form.

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._service) : super(const LoginState());

  final AuthService _service;

  Future<void> submit({required String email, required String password}) async {
    if (state.isSubmitting) return;
    emit(const LoginState(status: LoginStatus.submitting));
    try {
      final user = await _service.signInWithEmail(
        email: email,
        password: password,
      );
      emit(LoginState(status: LoginStatus.success, user: user));
    } on AuthFailure catch (failure) {
      emit(LoginState(status: LoginStatus.failure, failure: failure));
    }
  }
}

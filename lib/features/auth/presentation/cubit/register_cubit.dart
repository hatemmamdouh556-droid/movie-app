import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';
import 'package:movies_app/features/auth/domain/auth_user.dart';

part 'register_status.dart';
part 'register_state.dart';

/// Status of the registration form.

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._service) : super(const RegisterState());

  final AuthService _service;

  Future<void> submit({
    required String name,
    required String email,
    required String password,
    String? avatarPath,
  }) async {
    if (state.isSubmitting) return;
    emit(const RegisterState(status: RegisterStatus.submitting));
    try {
      final user = await _service.registerWithEmail(
        name: name,
        email: email,
        password: password,
        photoUrl: avatarPath,
      );
      emit(RegisterState(status: RegisterStatus.success, user: user));
    } on AuthFailure catch (failure) {
      emit(RegisterState(status: RegisterStatus.failure, failure: failure));
    }
  }
}

part of 'login_cubit.dart';

class LoginState {
  const LoginState({this.status = LoginStatus.idle, this.user, this.failure});

  final LoginStatus status;
  final AppUser? user;
  final AuthFailure? failure;

  bool get isSubmitting => status == LoginStatus.submitting;

  bool get hasFailed => status == LoginStatus.failure;
}

/// Handles the login form: one request at a time and errors translated to
/// [AuthFailure]s that the screen renders next to the fields.

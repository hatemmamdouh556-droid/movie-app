import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';
import 'package:movies_app/features/auth/domain/auth_user.dart';

part 'auth_status.dart';
part 'auth_state.dart';

/// High level authentication status of the application.

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.service, {this.requireEmailVerification = true})
    : super(const AuthState.unknown()) {
    _authStateSubscription = service.authStateChanges().listen(
      _onAuthStateChanged,
      // A broken session stream must never block the app: the user is treated
      // as signed out and can try to sign in again.
      onError: (Object _) => emit(const AuthState.unauthenticated()),
    );
  }

  final AuthService service;

  /// Project policy: when `true`, unverified emails cannot reach the home
  /// screen.
  final bool requireEmailVerification;

  late final StreamSubscription<AppUser?> _authStateSubscription;

  void _onAuthStateChanged(AppUser? user) => emit(_stateFor(user));

  AuthState _stateFor(
    AppUser? user, {
    bool isRefreshing = false,
    AuthFailure? refreshFailure,
  }) => AuthState.fromUser(
    user,
    requireEmailVerification: requireEmailVerification,
    isRefreshing: isRefreshing,
    refreshFailure: refreshFailure,
  );

  /// Reloads the provider profile and reports the real verification state.
  ///
  /// Returns `true` when verified, `false` when still unverified and `null`
  /// when the profile could not be reloaded (for example offline).
  Future<bool?> refreshUser() async {
    if (state.isRefreshing) return state.isEmailVerified;
    final currentUser = state.user;
    emit(_stateFor(currentUser, isRefreshing: true));
    try {
      final user = await service.reloadCurrentUser();
      emit(_stateFor(user));
      return user?.emailVerified ?? false;
    } on AuthFailure catch (failure) {
      emit(_stateFor(currentUser, refreshFailure: failure));
      return null;
    }
  }

  /// Ends the session; the stream moves the app back to the login screen.
  Future<void> signOut() => service.signOut();

  @override
  Future<void> close() async {
    await _authStateSubscription.cancel();
    return super.close();
  }
}

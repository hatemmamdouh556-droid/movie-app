part of 'auth_cubit.dart';

class AuthState {
  const AuthState._({
    required this.status,
    this.user,
    this.isRefreshing = false,
    this.refreshFailure,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  factory AuthState.fromUser(
    AppUser? user, {
    bool requireEmailVerification = true,
    bool isRefreshing = false,
    AuthFailure? refreshFailure,
  }) {
    if (user == null) return const AuthState.unauthenticated();
    final status = requireEmailVerification && !user.emailVerified
        ? AuthStatus.emailNotVerified
        : AuthStatus.authenticated;
    return AuthState._(
      status: status,
      user: user,
      isRefreshing: isRefreshing,
      refreshFailure: refreshFailure,
    );
  }

  final AuthStatus status;
  final AppUser? user;
  final bool isRefreshing;
  final AuthFailure? refreshFailure;

  bool get isSignedIn => user != null;

  bool get isEmailVerified => user?.emailVerified ?? false;
}

/// Single source of truth of the authentication session.
///
/// It listens to the provider session stream, so signing in, signing out or
/// updating the profile is reflected everywhere without any screen having to
/// navigate manually.

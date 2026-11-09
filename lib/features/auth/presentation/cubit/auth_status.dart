part of 'auth_cubit.dart';

enum AuthStatus {
  /// The session is being restored and we do not know yet whether a user is
  /// signed in.
  unknown,

  /// No user is signed in.
  unauthenticated,

  /// A user is signed in but the email address is not verified yet.
  emailNotVerified,

  /// A user is signed in and (when required) the email is verified.
  authenticated,
}

/// State of the authentication session.

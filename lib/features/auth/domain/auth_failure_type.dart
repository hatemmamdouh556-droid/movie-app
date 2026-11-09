part of 'auth_failure.dart';

enum AuthFailureType {
  invalidEmail,
  weakPassword,
  invalidCredentials,
  emailAlreadyInUse,
  userDisabled,
  tooManyRequests,
  networkError,
  requiresRecentLogin,
  operationNotAllowed,
  invalidActionCode,
  unknown,
}

/// Error returned by [AuthService].
///
/// Raw provider errors never leave the service: they are translated into an
/// [AuthFailure] with a [type] the UI understands.

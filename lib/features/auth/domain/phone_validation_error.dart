part of 'auth_validators.dart';

enum PhoneValidationError { invalidFormat }

/// Validation rules shared by the authentication and profile forms.
///
/// They are plain Dart helpers so every screen applies the same rules. The
/// provider remains the final authority on credentials.

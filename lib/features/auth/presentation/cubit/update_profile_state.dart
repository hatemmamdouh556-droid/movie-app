part of 'update_profile_cubit.dart';

class UpdateProfileState {
  const UpdateProfileState({
    this.status = UpdateProfileStatus.idle,
    this.user,
    this.failure,
  });

  final UpdateProfileStatus status;
  final AppUser? user;
  final AuthFailure? failure;

  bool get isSubmitting => status == UpdateProfileStatus.submitting;

  bool get isSuccess => status == UpdateProfileStatus.success;

  bool get hasFailed => status == UpdateProfileStatus.failure;
}

/// Saves the editable profile data.
///
/// Name and avatar live in the Firebase profile (so they follow the account).
/// The phone number has no provider field, so it is kept in the existing local
/// preferences utility.

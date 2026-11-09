part of 'delete_account_cubit.dart';

class DeleteAccountState {
  const DeleteAccountState({
    this.status = DeleteAccountStatus.idle,
    this.failure,
  });

  final DeleteAccountStatus status;
  final AuthFailure? failure;

  bool get isSubmitting => status == DeleteAccountStatus.submitting;

  bool get isSuccess => status == DeleteAccountStatus.success;

  bool get hasFailed => status == DeleteAccountStatus.failure;
}

/// Deletes the account after re-authenticating the user.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';

part 'delete_account_status.dart';
part 'delete_account_state.dart';

/// Status of the "delete account" request.

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._service) : super(const DeleteAccountState());

  final AuthService _service;

  Future<void> confirmDeletion(String password) async {
    if (state.isSubmitting) return;
    emit(const DeleteAccountState(status: DeleteAccountStatus.submitting));
    try {
      await _service.reauthenticateWithPassword(password);
      await _service.deleteAccount();
      emit(const DeleteAccountState(status: DeleteAccountStatus.success));
    } on AuthFailure catch (failure) {
      emit(
        DeleteAccountState(
          status: DeleteAccountStatus.failure,
          failure: failure,
        ),
      );
    }
  }
}

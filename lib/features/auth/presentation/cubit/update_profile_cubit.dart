import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/data/auth_service.dart';
import 'package:movies_app/features/auth/domain/auth_user.dart';
import 'package:movies_app/utils/app_prefs.dart';

part 'update_profile_status.dart';
part 'update_profile_state.dart';

/// Status of the profile update request.

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._service) : super(const UpdateProfileState());

  final AuthService _service;

  Future<void> update({
    required String name,
    required String phone,
    required String avatarPath,
  }) async {
    if (state.isSubmitting) return;
    emit(const UpdateProfileState(status: UpdateProfileStatus.submitting));
    try {
      final user = await _service.updateProfile(
        name: name,
        photoUrl: avatarPath,
      );
      await AppPrefs.setProfilePhone(phone.trim());
      emit(UpdateProfileState(status: UpdateProfileStatus.success, user: user));
    } on AuthFailure catch (failure) {
      emit(
        UpdateProfileState(
          status: UpdateProfileStatus.failure,
          failure: failure,
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/domain/auth_validators.dart';
import 'package:movies_app/features/auth/presentation/widgets/avatar_selector.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_form_message.dart';
import 'package:movies_app/features/auth/presentation/widgets/delete_account_dialog.dart';
import 'package:movies_app/features/onboarding/presentation/widgets/language_switch.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/shared/widgets/custom_text_field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_prefs.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/features/auth/presentation/widgets/avatar_picker_sheet.dart';

part 'update_profile_view.dart';
part 'update_profile_view_state.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProfileCubit>(
      create: (context) =>
          UpdateProfileCubit(context.read<AuthCubit>().service),
      child: const _UpdateProfileView(),
    );
  }
}

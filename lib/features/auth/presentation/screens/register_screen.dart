import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/domain/auth_validators.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_field_defaults.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_form_message.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_page_scaffold.dart';
import 'package:movies_app/features/auth/presentation/widgets/avatar_selector.dart';
import 'package:movies_app/features/auth/presentation/widgets/password_field.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/shared/widgets/custom_text_field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_prefs.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'register_view.dart';
part 'register_view_state.dart';

/// Account creation screen.

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(context.read<AuthCubit>().service),
      child: const _RegisterView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/domain/auth_validators.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_field_defaults.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_form_message.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_page_scaffold.dart';
import 'package:movies_app/features/auth/presentation/widgets/password_field.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/shared/widgets/custom_text_field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'login_view.dart';
part 'login_view_state.dart';

/// Email + password login screen.

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(context.read<AuthCubit>().service),
      child: const _LoginView(),
    );
  }
}

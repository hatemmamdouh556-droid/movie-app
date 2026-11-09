import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/domain/auth_validators.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_form_message.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/shared/widgets/custom_text_field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'reset_password_view.dart';
part 'reset_password_view_state.dart';

/// مسار صورة الشاشة. صدّرها من Figma (الفريم 430x430) باسم
/// forget_password.png وحطها في assets/images
const String kForgetPasswordImage = AppAssets.forgetPassword;

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) =>
          ForgotPasswordCubit(context.read<AuthCubit>().service),
      child: const _ResetPasswordView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/email_verification_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_field_defaults.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_page_scaffold.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'email_verification_view.dart';
part 'email_verification_view_state.dart';

/// Screen shown while the email address of the user is not verified yet.
///
/// It only ever reads the verification state from the provider: pressing the
/// button here cannot mark an email as verified.

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmailVerificationCubit>(
      create: (context) =>
          EmailVerificationCubit(context.read<AuthCubit>().service),
      child: const _EmailVerificationView(),
    );
  }
}

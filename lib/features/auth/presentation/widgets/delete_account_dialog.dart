import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_messages.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/delete_account_cubit.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_field_defaults.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_form_message.dart';
import 'package:movies_app/features/auth/presentation/widgets/password_field.dart';
import 'package:movies_app/shared/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'delete_account_dialog_view.dart';
part 'delete_account_dialog_view_state.dart';

/// Confirmation dialog of the "delete account" action.
///
/// Deleting an account is a sensitive operation, so the user has to type the
/// password again: the cubit re-authenticates before the account is removed.

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const DeleteAccountDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAccountCubit>(
      create: (context) =>
          DeleteAccountCubit(context.read<AuthCubit>().service),
      child: const _DeleteAccountDialogView(),
    );
  }
}

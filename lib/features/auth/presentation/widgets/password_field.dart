import 'package:flutter/material.dart';
import 'package:movies_app/shared/widgets/custom_text_field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/features/auth/presentation/widgets/auth_field_defaults.dart';

part 'password_field_state.dart';

/// Password input with a show/hide action.

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.autofocus = false,
  });

  final String label;

  final String? hint;

  final TextEditingController? controller;

  final OnValidator? validator;

  final TextInputAction textInputAction;

  final ValueChanged<String>? onFieldSubmitted;

  final bool autofocus;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

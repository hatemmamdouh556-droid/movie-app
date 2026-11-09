import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'or_divider.dart';

/// "Don't Have Account ? Create One" style line.

class AuthFooterText extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback? onTap;

  const AuthFooterText({
    super.key,
    required this.question,
    required this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          style: AppStyles.white14,
          children: [
            TextSpan(text: '$question '),
            TextSpan(text: action, style: AppStyles.bold14Primary),
          ],
        ),
      ),
    );
  }
}

/// ———— OR ———— divider.

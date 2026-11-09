import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileActionButton extends StatelessWidget {
  ProfileActionButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return SizedBox(
      height: context.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.037),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: AppStyles.white20.copyWith(color: textColor)),
            if (icon != null) ...[
              SizedBox(width: width * 0.019),
              Icon(icon, size: width * 0.056),
            ],
          ],
        ),
      ),
    );
  }
}

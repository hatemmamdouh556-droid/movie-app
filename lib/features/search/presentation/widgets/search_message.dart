import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class SearchMessage extends StatelessWidget {
  const SearchMessage({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: AppColors.primaryColor),
          SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center, style: AppStyles.white16),
        ],
      ),
    ),
  );
}

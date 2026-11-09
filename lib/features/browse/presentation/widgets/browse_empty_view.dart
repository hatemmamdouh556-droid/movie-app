import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class BrowseEmptyView extends StatelessWidget {
  const BrowseEmptyView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.movie_filter_outlined,
            size: 52,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center, style: AppStyles.white16),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class BrowseErrorView extends StatelessWidget {
  const BrowseErrorView({
    super.key,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.white70),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center, style: AppStyles.white14),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(retryLabel),
          ),
        ],
      ),
    ),
  );
}

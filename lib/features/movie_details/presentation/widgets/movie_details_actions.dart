import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class MovieDetailsActions extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onBookmarkTap;
  final VoidCallback onBackTap;

  const MovieDetailsActions({
    super.key,
    required this.isSelected,
    required this.onBookmarkTap,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBackTap,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.whiteColor,
            ),
          ),
          IconButton(
            onPressed: onBookmarkTap,
            icon: Icon(
              isSelected ? Icons.bookmark : Icons.bookmark_border,
              color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class AvatarPickerSheet extends StatelessWidget {
  const AvatarPickerSheet({
    super.key,
    required this.avatars,
    required this.selected,
    required this.onSelected,
  });

  final List<String> avatars;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkFieldColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          final isSelected = index == selected;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.6)
                    : AppColors.transparentColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Image.asset(avatars[index], fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }
}

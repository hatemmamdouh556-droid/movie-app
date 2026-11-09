import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  final bool isDark;

  const CustomLoadingWidget({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: isDark ? AppColors.whiteColor : AppColors.primaryColor,
      ),
    );
  }
}

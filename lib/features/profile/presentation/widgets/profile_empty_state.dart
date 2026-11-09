import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileEmptyState extends StatelessWidget {
  ProfileEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.local_movies_outlined,
        size: context.width * 0.223,
        color: AppColors.primaryColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileStat extends StatelessWidget {
  ProfileStat({required this.count, required this.label});

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count', style: AppStyles.bold36White),
        SizedBox(height: context.height * 0.017),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: AppStyles.bold20White.copyWith(fontSize: 22),
          ),
        ),
      ],
    );
  }
}

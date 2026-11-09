import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class MovieGradient extends StatelessWidget {
  const MovieGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.0, 1.0],
            colors: [
              AppColors.blackOverlayStart,
              AppColors.blackOverlayMiddle,
              AppColors.blackOverlayEnd,
            ],
          ),
        ),
      ),
    );
  }
}

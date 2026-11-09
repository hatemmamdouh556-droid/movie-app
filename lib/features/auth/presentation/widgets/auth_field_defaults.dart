import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

/// Default colors and text styles of the authentication form fields.
///
/// The values mirror the design used by the existing screens so the flow looks
/// identical wherever it is opened from.
class AuthFieldDefaults {
  const AuthFieldDefaults._();

  static const Color fillColor = AppColors.darkFieldColor;

  static const Color borderColor = AppColors.transparentColor;

  static const Color iconColor = AppColors.whiteColor;

  static final TextStyle textStyle = AppStyles.white16;

  static final TextStyle hintStyle = AppStyles.white14;

  static final TextStyle labelStyle = AppStyles.white14;
}

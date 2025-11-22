import 'package:easacc_task/core/utils/app_colors.dart';
import 'package:flutter/widgets.dart';

class AppTextStyle {
  static const TextStyle textStyleBold32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static const TextStyle textStyleRegular16 = TextStyle(
    fontSize: 16,
    color: AppColors.grey,
  );
  static const TextStyle textStyleRegular12 = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
  );

  static const TextStyle textStyleRegularUnderline = TextStyle(
    color: Color(0xFF1877F2),
    decoration: TextDecoration.underline,
  );
  static const TextStyle textStyleSemiBold18 = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

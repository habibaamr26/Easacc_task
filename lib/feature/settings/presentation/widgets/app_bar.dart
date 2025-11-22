import 'package:easacc_task/core/utils/app_colors.dart';
import 'package:easacc_task/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

PreferredSizeWidget? customAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,

    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.black),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Text('Settings', style: AppTextStyle.textStyleSemiBold18),
    centerTitle: true,
  );
}

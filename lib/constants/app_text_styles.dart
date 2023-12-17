import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._(); // this basically makes it so you can't instantiate this class

  static const appBarTextStyle = TextStyle(
    color: AppColors.grey,
  );

  static const characterNameTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const hintFieldTextStyle = TextStyle(
    color: AppColors.grey,
    fontSize: 18,
  );

  static const nickNameTextStyle = TextStyle(
    color: AppColors.white,
  );

  static const titleInfoTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const valueInfoTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );
}

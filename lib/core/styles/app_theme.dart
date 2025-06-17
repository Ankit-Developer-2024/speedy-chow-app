
import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class AppTheme{
  static final ThemeData lightTheme=ThemeData(
    colorScheme: ColorScheme.light(primary: AppColors.darkOrange),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppColors.white,
      elevation: 8,
      surfaceTintColor: AppColors.white,
      titleTextStyle: AppTextStyles.regular14P(color: AppColors.justBlack),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.spacing_8)),
      hintStyle:const TextStyle(color: AppColors.grey300),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.spacing_8),
          borderSide: BorderSide(color: AppColors.darkOrange)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.spacing_8),
          borderSide: BorderSide(color: AppColors.errorRed)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.spacing_8),
          borderSide: BorderSide(color: AppColors.errorRed)
      ),
      border:  OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.spacing_8)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.spacing_8),
          borderSide: BorderSide(color: AppColors.black)
      ) ,
      errorStyle: TextStyle(color: AppColors.errorRed),
      floatingLabelStyle:const TextStyle(color: AppColors.darkOrange),
      labelStyle: const TextStyle(color: AppColors.grey500),

    )


  );
}
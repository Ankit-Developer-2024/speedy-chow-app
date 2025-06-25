import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
  BuildContext context,
  String title, {
  int? seconds,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  Color? bgColor,
  Color? textColor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title,style: AppTextStyles.bold14P(color: textColor ?? AppColors.white),),
      duration: Duration(seconds: seconds ?? 2),
      padding: padding ??EdgeInsets.all(AppDimensions.spacing_16),
      margin:  margin,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
      backgroundColor: bgColor ?? AppColors.darkOrange.withValues(alpha: 0.9),

    ),
  );
}

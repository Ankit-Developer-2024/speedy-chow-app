import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

Future customLoaderDialog({
  required BuildContext context,
  required String title,
}) {
  return showAdaptiveDialog(
    useSafeArea: true,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimensions.spacing_8,
           children: [
             CupertinoActivityIndicator(color: AppColors.black,animating: true,radius: AppDimensions.radius_12,) ,
             Expanded(child: Text(title,maxLines: 2,style: AppTextStyles.regular16P(),))
           ],
        ),
      );
    }
  );
}

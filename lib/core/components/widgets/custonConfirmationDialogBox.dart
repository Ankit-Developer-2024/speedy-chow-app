import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

Future customConfirmationDialogBox({
  required BuildContext context,
  required String title,
  required String msg,
  String? leftButtonTitle,
  bool isLeftButtonRequired=true,
  required String rightButtonTitle,
  required VoidCallback onPress
}) {
  return showAdaptiveDialog(
    useSafeArea: true,
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      titleTextStyle: AppTextStyles.semiBold18P(),
      content: Text(msg,style: AppTextStyles.regular14P(),),

      actions: [
        Row(
          spacing: AppDimensions.spacing_8,
          children: [
            isLeftButtonRequired ? Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
                  elevation: 0,

                ),
                onPressed: () {
                  context.pop();
                },
                child: Text( leftButtonTitle ?? AppLocal.cancel.getString(context),style: AppTextStyles.medium16P(color: AppColors.white),),
              ),
            ) : SizedBox.shrink() ,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
                  elevation: 0,

                ),
                onPressed: onPress,
                child: Text(rightButtonTitle,style: AppTextStyles.medium16P(color: AppColors.white),),
              ),
            ),

          ],
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
  );
}

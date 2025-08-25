import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/personal_data_drop_down.dart';
import 'package:speedy_chow/core/components/widgets/text_field_widget.dart';

Future userDataChangeDialogDropDown({
  required BuildContext context,
  required String title,
  String? leftButtonTitle,
  bool isLeftButtonRequired=true,
  required String rightButtonTitle,
  required VoidCallback rightOnPress,
  VoidCallback? leftOnPress,
  required TextEditingController controller,
}) {
  return showAdaptiveDialog(
    useSafeArea: true,
    barrierDismissible: false,
    barrierColor: AppColors.white.withAlpha(0),
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      titleTextStyle: AppTextStyles.semiBold18P(),
      content: PersonalDataDropDown(
        title: AppLocal.gender.getString(context),
        controller: controller,
      ),
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
                onPressed: leftOnPress ?? () {
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
                onPressed: rightOnPress,
                child: Text(rightButtonTitle,style: AppTextStyles.medium16P(color: AppColors.white),),
              ),
            ),

          ],
        ),
      ],
      elevation: 20,
      shadowColor: AppColors.darkOrange,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          side: BorderSide(color: AppColors.grey500)
      ),
    ),
  );
}

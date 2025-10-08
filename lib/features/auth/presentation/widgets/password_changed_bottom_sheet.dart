import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

Future<dynamic> passwordChangedBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (context) {
      return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(AppDimensions.spacing_24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radius_16),
            topRight: Radius.circular(AppDimensions.radius_16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppDimensions.spacing_12,
          children: [
            SizedBox(
                width: 150,height: 150,
                child: SvgPicture.asset(getLocalSvg("success"),fit: BoxFit.cover,)),
            Text(
              AppLocal.passwordChanged.getString(context),
              style: AppTextStyles.semiBold24P(),
            ),
            SizedBox(height: AppDimensions.spacing_16,),
            Button(
              onTap: () {
                 context.goNamed(AppRoutes.login);
              },
              child: Text(
                AppLocal.continueText.getString(context),
                textAlign: TextAlign.center,
                style: AppTextStyles.medium20P(color: AppColors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}

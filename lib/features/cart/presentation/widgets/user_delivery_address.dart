import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class UserDeliveryAddress extends StatelessWidget {
  const UserDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.spacing_10,
      children: [
        Text(
          "${AppLocal.deliveryTo.getString(context)} User Name",
          style: AppTextStyles.semibold18P(),
        ),
        Text(
          "H.NO. 11 village -Chabbarwal , Post Office -Shekupur Daroli, vVllage-Chabbarwal , Post Office -Shekupur Daroli, Adampur, HISAR, HARYANA, 125052, India",
          style: AppTextStyles.medium14P(),
        ),
        TextButton(onPressed: (){}, child: Text("Change delivery Address")),
        Container(
          height: AppDimensions.size_1,
          decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(AppDimensions.radius_100)
          ),
        )
      ],
    );
  }
}

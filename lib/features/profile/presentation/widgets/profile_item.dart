import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key,required this.onTap,required this.icon ,required this.text});
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radius_8),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.spacing_8),
        decoration: BoxDecoration(
            color: AppColors.grey50.withAlpha(80),
            borderRadius: BorderRadius.circular(AppDimensions.radius_8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: AppDimensions.spacing_10,
              children: [
                Icon(icon),
                Text(text,style: AppTextStyles.medium18P(),)
              ],
            ),
            Icon(Icons.arrow_forward_ios_sharp,size: AppDimensions.size_18,)
          ],
        ),
      ),
    );
  }
}

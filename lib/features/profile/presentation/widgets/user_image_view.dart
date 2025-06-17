import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class UserImageView extends StatelessWidget {
  const UserImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:(){},
      borderRadius: BorderRadius.circular(AppDimensions.radius_12),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            maxRadius: 70,
            child: SvgPicture.asset(
              getLocalSvg("speedychow_logo"),
              fit: BoxFit.fill,
            ),
          ),
          Container(
              padding: EdgeInsets.all(AppDimensions.spacing_10),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radius_100)
              ),
              child: Icon(Icons.camera_alt_outlined,color: AppColors.darkOrange,size: AppDimensions.size_32,)),
        ],
      ),
    );
  }
}

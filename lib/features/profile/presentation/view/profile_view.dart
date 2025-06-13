import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
      context.goNamed(AppRoutes.home);
    }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: AppDimensions.size_18,)),
    title: Text(AppLocal.profileSettings.getString(context),style: AppTextStyles.semibold18P(),),
    centerTitle: true,
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.size_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppDimensions.spacing_8,
                children: [
                  CircleAvatar(
                    maxRadius: 70,
                    child: SvgPicture.asset(getLocalSvg("speedychow_logo"),fit: BoxFit.fill,),
                  ),
                  Text("Ankit",style: AppTextStyles.semiBold18P(),),
                  Text("demo001@gmail.com",style: AppTextStyles.semiBold18P(color: AppColors.grey60),),
                  Container(
                    height: AppDimensions.size_4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                      color: AppColors.grey50,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

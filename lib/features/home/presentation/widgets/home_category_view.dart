

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/presentation/widgets/category_bottomSheet.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocal.findByCategory.getString(context),style: AppTextStyles.semiBold18P(),),
              TextButton(onPressed: (){
                 categoryBottomSheet(context);
              }, child: Text(AppLocal.seeAll.getString(context),style: AppTextStyles.medium16P(color: AppColors.darkOrange),))
            ],
          ),

          SizedBox(
              height: AppDimensions.size_88,
            child: ListView.separated(
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.all(AppDimensions.spacing_8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                  color: AppColors.darkOrange
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(getLocalSvg("success"),width: 40,height: 40,fit: BoxFit.contain,),
                    SizedBox(height: AppDimensions.spacing_8,),
                    Text("Burger",style: AppTextStyles.medium16P(color: AppColors.white),)
                  ],
                ),
              );
            },
              separatorBuilder: (context,index){
                  return SizedBox(width: AppDimensions.spacing_20,);
              },

            ),
          )
        ],
      ),
    );
  }
}

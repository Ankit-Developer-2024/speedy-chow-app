

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class OneTimeUi extends StatelessWidget{
  const OneTimeUi({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body:   Stack(
          children: [
           Image.asset(getLocalJpg("splash_bg_image",),fit: BoxFit.cover,width: MediaQuery.sizeOf(context).width, height:MediaQuery.sizeOf(context).height ,),
            Align(
              alignment: Alignment(0,0.8),
              child: Container(
                width: MediaQuery.sizeOf(context).width-70,
                height: MediaQuery.sizeOf(context).height/2,
                decoration: BoxDecoration(
                  color: AppColors.darkOrange,
                  borderRadius: BorderRadius.circular(AppDimensions.radius_50)
                ),
               child: Padding(
                 padding: const EdgeInsets.all(AppDimensions.spacing_22),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       spacing: AppDimensions.spacing_12,
                       children: [
                         Text(AppLocal.whatWeServe.getString(context),textAlign: TextAlign.center ,style: AppTextStyles.semiBold27P(color: AppColors.white),),
                         Text(AppLocal.whatWeServeDesc.getString(context),textAlign: TextAlign.center,style: AppTextStyles.light14P(color: AppColors.white),),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           spacing: 10,
                           children: [
                             Container(
                               width: AppDimensions.size_20,
                               height: AppDimensions.size_4,
                               decoration: BoxDecoration(
                                 color: AppColors.white,
                                 borderRadius: BorderRadius.circular(AppDimensions.radius_6)
                               ),
                             ),
                             Container(
                               width: AppDimensions.size_20,
                               height: AppDimensions.size_4,
                               decoration: BoxDecoration(
                                   color: AppColors.white,
                                   borderRadius: BorderRadius.circular(AppDimensions.radius_6)
                               ),
                             ),
                             Container(
                               width: AppDimensions.size_20,
                               height: AppDimensions.size_4,
                               decoration: BoxDecoration(
                                   color: AppColors.white.withValues(alpha: 0.5),
                                   borderRadius: BorderRadius.circular(AppDimensions.radius_6)
                               ),
                             ),
                           ],
                         )
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(onPressed: (){}, child: Text(AppLocal.skip.getString(context),style: AppTextStyles.semiBold14P(color: AppColors.white),)),
                         TextButton.icon(onPressed: (){},
                           iconAlignment: IconAlignment.end,
                           label: Text(AppLocal.next.getString(context),style: AppTextStyles.semiBold14P(color: AppColors.white)),
                           icon: Icon(Icons.arrow_forward,color: AppColors.white,size: AppDimensions.size_16,),)
                       ],
                     )
                   ],
                 ),
               ),
              ),
            )
          ],
        )
    );
  }



}
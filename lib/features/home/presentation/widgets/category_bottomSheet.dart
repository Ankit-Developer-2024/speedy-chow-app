
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

Future<dynamic> categoryBottomSheet(BuildContext context){
  return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      context: context,
      builder: (context){
       return SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           spacing: AppDimensions.spacing_8,
           children: [
             IconButton.filledTonal(
               color: AppColors.black,
               style: ButtonStyle(
                 backgroundColor: WidgetStateProperty.all(AppColors.white),
               ),
               onPressed: () {
                 context.pop();
               },
               icon: Icon(Icons.close_sharp),
             ),
             Container(
               width: double.maxFinite,
               padding: EdgeInsets.all(AppDimensions.spacing_24),
               decoration: BoxDecoration(
                 color: AppColors.white,
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(AppDimensions.radius_16),
                   topRight: Radius.circular(AppDimensions.radius_16),
                 ),
               ),
               child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                 alignment: WrapAlignment.start,
                 runSpacing: AppDimensions.spacing_8,
                 spacing: AppDimensions.spacing_8,
                 children: [
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
             ),
           ],
         ),
       );
  });
}
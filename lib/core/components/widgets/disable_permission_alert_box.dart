import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class DisablePermissionAlertBox extends StatelessWidget {
  const DisablePermissionAlertBox({super.key,required this.title,required this.desc});
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
         title:  Text(title,style: AppTextStyles.semiBold18P(),textAlign: TextAlign.center,),
         titleTextStyle: AppTextStyles.semiBold18P(),
         content: Text(desc,style: AppTextStyles.regular14P(),),
         actions: [
           Row(
             spacing: AppDimensions.spacing_8,
             children: [
               Expanded(
                 child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.darkOrange,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
                       elevation: 0,
                     ),
                     onPressed: (){
                   context.pop();
                   }, child: Text(AppLocal.cancel.getString(context),style: AppTextStyles.medium16P(color: AppColors.white),)),
               ),
               Expanded(
                 child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.darkOrange,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
                       elevation: 0,
                     ),
                     onPressed: ()async{
                   await openAppSettings();
                   context.pop();
                 }, child: Text(AppLocal.enable.getString(context),style: AppTextStyles.medium16P(color: AppColors.white),)),
               ),
             ],
           )


         ],
    ));
  }
}

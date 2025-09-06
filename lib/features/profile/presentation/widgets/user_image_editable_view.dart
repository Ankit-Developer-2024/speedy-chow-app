import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/util/helpers/camera_helper.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';

class UserImageEditableView extends StatelessWidget {
  const UserImageEditableView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProfileBloc , ProfileState>(
      listenWhen: (prev,curr)=> curr is PersonalDataPickImageState,
  listener: (context, state) {
     if(state is PersonalDataPickImageState){
       if(state.error==true){
         customSnackBar(context,AppLocal.swtwr.getString(context));
       }
     }
  },
      buildWhen: (prev,curr)=> curr is PersonalDataPickImageState,
  builder: (context, state) {
        if(state is PersonalDataPickImageState && state.error==false){
          return InkWell(
            onTap:()async{
              File? img=   await CameraHelper.pickImage(context: context);
              context.read<ProfileBloc>().add(PersonalDataPickImageEvent(image: img));
            },
            borderRadius: BorderRadius.circular(AppDimensions.radius_100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    maxRadius: 70,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                        child: Image.file(state.image!,fit: BoxFit.cover,alignment: Alignment.center,height: 139,width: 139,)),
                  ),
                  Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                          border: BoxBorder.fromSTEB(bottom: BorderSide(color: AppColors.darkOrange,width: 0.5),end: BorderSide(color: AppColors.darkOrange,width: 0.5))
                      ),
                      child: Icon(Icons.camera_alt_outlined,color: AppColors.darkOrange,size: AppDimensions.size_32,)),
                ],
              ),
            ),
          );
        }else{
           return InkWell(
            onTap:()async{
              File? img=  await CameraHelper.pickImage(context: context);
              context.read<ProfileBloc>().add(PersonalDataPickImageEvent(image: img));
            },
            borderRadius: BorderRadius.circular(AppDimensions.radius_100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
            ),
          );; 
        }

  },
);
  }
}

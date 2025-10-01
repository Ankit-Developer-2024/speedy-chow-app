import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/util/helpers/camera_helper.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/user_image.dart';

class UserImageEditableView extends StatelessWidget {
  const UserImageEditableView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => curr is PersonalDataPickImageState,
      listener: (context, state) {
        if (state is PersonalDataPickImageState) {
          if (state.loading == true) {
              customLoader(context: context);
          }else{
            state.msg!="Image not picked!" ? context.pop() : null;
            state.msg!="Image not picked!" ? customSnackBar(context, state.msg) : null;
          }
        }
      },
      buildWhen: (prev, curr) => curr is PersonalDataPickImageState,
      builder: (context, state) {
        if (state is PersonalDataPickImageState && state.success == true) {
          return InkWell(
            onTap: () async {
              File? img = (await CameraHelper.pickImage(context: context)) ;
              if(context.mounted){
                context
                    .read<ProfileBloc>()
                    .add(PersonalDataPickImageEvent(image: img));
              }
            },
            borderRadius: BorderRadius.circular(AppDimensions.radius_100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  context.read<ProfileBloc>().userModel!=null  && context.read<ProfileBloc>().userModel?.image!=null
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                      child: Image.memory( context.read<ProfileBloc>().userModel!.image!,fit: BoxFit.cover,width: 139,height: 139,))
                      : CircleAvatar(
                      radius: 70,
                      child: UserImage()),
                  Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radius_100),
                          border: BoxBorder.fromSTEB(
                              bottom: BorderSide(
                                  color: AppColors.darkOrange, width: 0.5),
                              end: BorderSide(
                                  color: AppColors.darkOrange, width: 0.5))),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.darkOrange,
                        size: AppDimensions.size_32,
                      )),
                ],
              ),
            ),
          );
        } else {
          return InkWell(
            onTap: () async {
              File? img = (await CameraHelper.pickImage(context: context)) ;
              if(context.mounted){
                context
                    .read<ProfileBloc>()
                    .add(PersonalDataPickImageEvent(image: img));
              }
            },
            borderRadius: BorderRadius.circular(AppDimensions.radius_100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  context.read<ProfileBloc>().userModel!=null  && context.read<ProfileBloc>().userModel?.image!=null
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                      child: Image.memory( context.read<ProfileBloc>().userModel!.image!,fit: BoxFit.cover,width: 139,height: 139,))
                      : CircleAvatar(
                      radius: 70,
                      child: UserImage()),
                  Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radius_100)),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.darkOrange,
                        size: AppDimensions.size_32,
                      )),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

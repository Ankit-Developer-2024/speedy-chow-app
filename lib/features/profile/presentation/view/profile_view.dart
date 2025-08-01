import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/custonConfirmationDialogBox.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/user_image_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.read<NavigationBloc>().add(
              NavigationTabChangedEvent(index: 0),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
        title: Text(
          AppLocal.profileSettings.getString(context),
          style: AppTextStyles.semibold18P(),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.size_24),
        child: BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (prev,curr)=> curr is ProfileSignOutConfirmState,
          listener: (context, state) {
             if(state is ProfileSignOutConfirmState){
               if(state.isLoading){
                 customLoaderDialog(context: context, title: "Sign out process start...");
               }
               else if(state.isSuccess){
                 context.pop();
                 context.pop();
                customSnackBar(context, "Sign out Successfully",seconds: 1);
                 context.goNamed(AppRoutes.login);
               }
               else if(!state.isSuccess && !state.isLoading){
                 context.pop();
                 context.pop();
                 customSnackBar(context, "Error");
               }
             }
          },
          child: Button(
            onTap: () {
              customConfirmationDialogBox(
                context: context,
                title: AppLocal.confirmSignOutTitle.getString(context),
                msg: AppLocal.confirmSignOutSubTitle.getString(context),
                rightButtonTitle: AppLocal.signOut.getString(context),
                onPress: () {
                  context.read<ProfileBloc>().add(ProfileSignOutConfirmEvent());
                },
              );
            },
            color: AppColors.transparent,
            border: Border.all(color: AppColors.errorRed),
            overlayColor: WidgetStateProperty.all(
              AppColors.errorRed.withAlpha(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppDimensions.spacing_10,
              children: [
                Icon(Icons.logout_sharp, color: AppColors.errorRed),
                Text(
                  AppLocal.signOut.getString(context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium16P(color: AppColors.errorRed),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.only(left: AppDimensions.size_24,right:AppDimensions.size_24,top: AppDimensions.size_24 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.spacing_20,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppDimensions.spacing_8,
                children: [
                  UserImageView(),
                  Text("Ankit", style: AppTextStyles.semiBold18P()),
                  Text(
                    "demo001@gmail.com",
                    style: AppTextStyles.semiBold18P(color: AppColors.grey60),
                  ),
                  Container(
                    height: AppDimensions.size_4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius_100,
                      ),
                      color: AppColors.grey50,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              AppLocal.profile.getString(context),
              style: AppTextStyles.medium20P(color: AppColors.grey60),
            ),
            ProfileItem(
              onTap: () {
                context.pushNamed(
                  AppRoutes.personalData,
                  extra: context.read<ProfileBloc>(),
                );
              },
              icon: Icons.person_2_outlined,
              text: AppLocal.personalData.getString(context),
            ),
            ProfileItem(
              onTap: () {
                context.pushNamed(
                  AppRoutes.settings,
                  extra: context.read<ProfileBloc>(),
                );
              },
              icon: Icons.settings,
              text: AppLocal.settings.getString(context),
            ),
            Text(
              AppLocal.support.getString(context),
              style: AppTextStyles.medium20P(color: AppColors.grey60),
            ),
            ProfileItem(
              onTap: () {
                context.pushNamed(
                  AppRoutes.helpCenter,
                  extra: context.read<ProfileBloc>(),
                );
              },
              icon: Icons.help_center_outlined,
              text: AppLocal.helpCenter.getString(context),
            ),
            ProfileItem(
              onTap: () {
                context.pushNamed(
                  AppRoutes.requestAccountDeletion,
                  extra: context.read<ProfileBloc>(),
                );
              },
              icon: Icons.delete_outline_rounded,
              text: AppLocal.requestAccountDeletion.getString(context),
            ),
          ],
        ),
      ),
    );
  }
}

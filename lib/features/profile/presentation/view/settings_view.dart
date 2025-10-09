import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/change_language_bottom_sheet.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/privacy_policay_bottom_sheet.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/terms_and_conditions_bottom_sheet.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: ProfileItemAppBar(title: AppLocal.settings.getString(context)),
    body: Padding(
      padding: const EdgeInsets.only(left: AppDimensions.size_24,right:AppDimensions.size_24,top: AppDimensions.size_24 ),
      child: Column(
        spacing: AppDimensions.spacing_10,
        children: [
          ProfileItem(onTap: ()async{
            changeLanguageBottomSheet(context);
             }, icon: Icons.language_outlined, text: AppLocal.language.getString(context)),
          ProfileItem(onTap: (){
            privacyPolicyBottomSheet(context);
          }, icon: Icons.privacy_tip_outlined, text: AppLocal.privacyPolicy.getString(context)),
          ProfileItem(onTap: (){
            termsAndConditionsBottomSheet(context);
          }, icon: Icons.file_open_outlined, text: AppLocal.termsAndConditions.getString(context))
        ],
      ),
    ),
    );
  }
}

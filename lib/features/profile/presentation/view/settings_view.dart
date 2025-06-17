import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: ProfileItemAppBar(title: AppLocal.settings.getString(context)),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.size_24),
      child: Column(
        spacing: AppDimensions.spacing_10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocal.location.getString(context),style: AppTextStyles.medium18P(),),
             Switch.adaptive(
               materialTapTargetSize:MaterialTapTargetSize.shrinkWrap ,
                 padding: EdgeInsets.zero,
                 value: false, onChanged: (val){})
            ],
          ),
          ProfileItem(onTap: (){}, icon: Icons.language_outlined, text: AppLocal.language.getString(context)),
          ProfileItem(onTap: (){}, icon: Icons.privacy_tip_outlined, text: AppLocal.privacyPolicy.getString(context)),
          ProfileItem(onTap: (){}, icon: Icons.file_open_outlined, text: AppLocal.termsAndConditions.getString(context))
        ],
      ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileItemAppBar(title: AppLocal.helpCenter.getString(context)) as PreferredSizeWidget,

    );
  }
}

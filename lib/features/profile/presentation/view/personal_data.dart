import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/text_field_widget.dart';

class PersonalData extends StatelessWidget {
  PersonalData({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop;
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
        title: Text(
          AppLocal.personalData.getString(context),
          style: AppTextStyles.semibold18P(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:AppDimensions.spacing_24),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 70,
              child: SvgPicture.asset(
                getLocalSvg("speedychow_logo"),
                fit: BoxFit.fill,
              ),
            ),
            Form(

              child: Column(
                children: [
                  TextFieldWidget(title: AppLocal.fullName.getString(context), controller: nameController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

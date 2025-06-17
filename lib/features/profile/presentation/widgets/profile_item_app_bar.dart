import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class ProfileItemAppBar extends StatelessWidget implements PreferredSizeWidget {
   const ProfileItemAppBar({super.key,required this.title});
   final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: ()async{
          FocusScope.of(context).unfocus();
          await Future.delayed(Duration(milliseconds: 150));
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_sharp,
          size: AppDimensions.size_18,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.semibold18P(),
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(  statusBarColor: AppColors.black,
        statusBarIconBrightness: Brightness.light,),
    );
  }

  @override
  Size get preferredSize => Size(10, 56);
}

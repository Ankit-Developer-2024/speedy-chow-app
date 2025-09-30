import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class ErrorMsgWidget extends StatelessWidget {
  const ErrorMsgWidget({super.key,required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 2,
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppDimensions.spacing_8,
        children: [
          SvgPicture.asset(getLocalSvg('cart_empty'),width: MediaQuery.sizeOf(context).width/2),
          Text(msg,style: AppTextStyles.semiBold20P(),),
          PrimaryButton(onPress: (){
            context.pop();
          },title:AppLocal.back.getString(context) ,titleStyle: AppTextStyles.medium16P(color: AppColors.white),)
        ],
      ),
    );
  }
}

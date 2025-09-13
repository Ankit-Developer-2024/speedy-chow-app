import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppDimensions.spacing_10,
      children: [
        SvgPicture.asset(getLocalSvg('cart_empty'),width: MediaQuery.sizeOf(context).width/2),
        Text(AppLocal.noOrderFound.getString(context),style: AppTextStyles.semiBold24P(),),
        Text(AppLocal.noOrderYet.getString(context),style: AppTextStyles.medium18P(color: AppColors.grey500),textAlign: TextAlign.center,),
        SizedBox(height: AppDimensions.spacing_20,),
        Button(onTap: (){
          context.read<NavigationBloc>().add(NavigationTabChangedEvent(index: 0));
        }, child: Center(child: Text(AppLocal.backToHome.getString(context),style: AppTextStyles.medium16P(color: AppColors.white),),))
      ],
    );
  }
}

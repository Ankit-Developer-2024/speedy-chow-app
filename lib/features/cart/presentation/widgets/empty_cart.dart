import 'package:flutter/cupertino.dart';
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

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppDimensions.spacing_20,
        children: [
          SvgPicture.asset(getLocalSvg("cart_empty"),width: AppDimensions.size_300,),
          Text(AppLocal.ouchHungry.getString(context),style: AppTextStyles.semiBold30P(),),
          Text(AppLocal.notOrderedAnyFood.getString(context),textAlign: TextAlign.center,style: AppTextStyles.medium16P(color: AppColors.grey500),),
          Button(onTap: (){
            context.read<NavigationBloc>().add(NavigationTabChangedEvent(index: 0));
          }, child: Text(AppLocal.findFood.getString(context),textAlign: TextAlign.center,style: AppTextStyles.semiBold18P(color: AppColors.white),))
        ],
      ),
    );
  }
}

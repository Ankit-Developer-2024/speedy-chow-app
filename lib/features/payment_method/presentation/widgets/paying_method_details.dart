import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

class PayingMethodDetails extends StatelessWidget {
  const PayingMethodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: AppDimensions.spacing_5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width-100,
                    child: Text("${AppLocal.payingWith.getString(context)} ${context.read<PaymentMethodBloc>().paymentMethod=="COD" ? AppLocal.cashOnDelivery.getString(context) : context.read<PaymentMethodBloc>().paymentMethod}",style: AppTextStyles.semibold18P())
                ),
                TextButton(onPressed: (){
                  context.pop();
                },
                style: ButtonStyle(
                   padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: AppDimensions.spacing_4),),
                   tapTargetSize:MaterialTapTargetSize.shrinkWrap
                ),
                child: Text(AppLocal.changePaymentMethod.getString(context),style:AppTextStyles.medium14P(color: AppColors.darkOrange),)
                )
              ],
            ),
             SvgPicture.asset(getLocalSvg("rupee"),width: 45,)
           ],
        )
      ],
    );
  }
}



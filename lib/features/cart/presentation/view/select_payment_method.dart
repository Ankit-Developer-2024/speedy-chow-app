import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/payment_methods.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/user_delivery_address.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.spacing_24,
          right: AppDimensions.spacing_24,
          top: AppDimensions.spacing_10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.spacing_10,
          children: [
            UserDeliveryAddress(),
            PrimaryButton(
              onPress: (){
               print("${ context.read<CartBloc>()}");
               },
              title:AppLocal.continueText.getString(context),
              titleStyle: AppTextStyles.medium18P(color: AppColors.white),
            ),
            PaymentMethods()
          ],
        ),
      ),
    );
  }
}

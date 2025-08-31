import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimensions.spacing_10,
      children: [
        BlocBuilder<PaymentMethodBloc,PaymentMethodState>(
            buildWhen: (prev,curr)=>curr is IsPaymentMethodErrorVisibleState,
            builder: (context,state){
             if(state is IsPaymentMethodErrorVisibleState){
               return state.isErrorVisible ? Row(
                 mainAxisSize: MainAxisSize.min,
                 spacing: AppDimensions.spacing_10,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Icon(Icons.error_rounded,color: AppColors.red1000,),
                   Expanded(child: Text("Please enter your payment information to continue.",style: AppTextStyles.medium14P(color: AppColors.red1000),))
                 ],
               )
                   :SizedBox.shrink();
             }else{
               return SizedBox.shrink();
             }
        }),
        
        PrimaryButton(
          onPress: (){
            if(context.read<PaymentMethodBloc>().paymentMethod.trim().isEmpty ){
              context.read<PaymentMethodBloc>().add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: true));
            }else{
              context.read<PaymentMethodBloc>().add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
              context.pushNamed(AppRoutes.createOrder,extra: context.read<PaymentMethodBloc>());
            }

          },
          title:AppLocal.continueText.getString(context),
          titleStyle: AppTextStyles.medium18P(color: AppColors.white),
        ),
        Text(
          AppLocal.selectPaymentMethod.getString(context),
          style: AppTextStyles.semiBold20P(),
        ),
        BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        buildWhen: (prev,curr)=> curr is SelectPaymentMethodState,
        builder: (context, state) {
         return ListView(
          shrinkWrap: true, 
          physics: NeverScrollableScrollPhysics(),
          children: [
            CheckboxMenuButton(
              value: context.read<PaymentMethodBloc>().paymentMethod=="COD" ? true :false,
              onChanged: (val) {
                 context.read<PaymentMethodBloc>()..add(SelectPaymentMethodEvent(paymentMethod: "COD"))..add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
              },
              child: Text(
                AppLocal.cashOnDelivery.getString(context),
                style: AppTextStyles.medium14P(),
              ),
            ),
            CheckboxMenuButton(
              value: context.read<PaymentMethodBloc>().paymentMethod=="UPI" ? true :false,
              onChanged: (val) {
                context.read<PaymentMethodBloc>()..add(SelectPaymentMethodEvent(paymentMethod: "UPI"))..add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
              },
              child: Text("UPI", style: AppTextStyles.medium14P()),
            ),
          ],
        );
  },
)

      ],
    );
  }
}

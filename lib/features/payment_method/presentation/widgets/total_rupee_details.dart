import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

class TotalRupeeDetails extends StatelessWidget {
  const TotalRupeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      buildWhen: (prev,curr)=> curr is FetchCartState,
  builder: (context, state) {
     if( state is FetchCartState){
       return Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("${AppLocal.items.getString(context)}:",style: AppTextStyles.medium16P()),
               Text("₹${context.read<PaymentMethodBloc>().totalPrice}",style: AppTextStyles.medium16P()),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(AppLocal.delivery.getString(context),style: AppTextStyles.medium16P()),
               Text("₹00",style: AppTextStyles.medium16P()),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("${context.read<PaymentMethodBloc>().paymentMethod} fee:",style: AppTextStyles.medium16P()),
               Text("₹00",style: AppTextStyles.medium16P()),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(AppLocal.orderTotal.getString(context),style: AppTextStyles.semiBold18P(),),
               Text("₹${context.read<PaymentMethodBloc>().totalPrice}",style: AppTextStyles.semiBold18P()),
             ],
           ),
         ],
       );
     }else{
       return SizedBox.shrink();
     }
  },
);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';

class CartTotalAmountDetails extends StatelessWidget {
  const CartTotalAmountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prev,curr)=>curr is CartFetchUserCartState,
      builder: (context, state) {
        if(state is CartFetchUserCartState){
          if(state.loading==true){
            return SizedBox.shrink();
          }else if(state.data.cartItem!.isEmpty){
            return SizedBox.shrink();
          }else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppLocal.items.getString(context)}(${state.data.cartItem!.length}):",
                      style: AppTextStyles.semibold18P(),
                    ),
                    Text(
                      "₹${state.data.totalPrice}",
                      style: AppTextStyles.semibold18P(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocal.delivery.getString(context),
                      style: AppTextStyles.semibold18P(),
                    ),
                    Text(
                      "₹00.00",
                      style: AppTextStyles.semibold18P(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocal.orderTotal.getString(context),
                      style: AppTextStyles.semibold18P(),
                    ),
                    Text(
                      "₹${state.data.totalPrice}",
                      style: AppTextStyles.semibold18P(),
                    ),
                  ],
                ),
              ],
            );
          }
        }else{
          return SizedBox.shrink();
        }
      },
    );
  }
}

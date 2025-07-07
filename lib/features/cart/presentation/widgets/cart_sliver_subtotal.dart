import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';


class CartSliverSubtotal extends StatelessWidget {
  const CartSliverSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prev,curr)=>curr is CartFetchUserCartState,
      builder: (context, state) {
        if(state is CartFetchUserCartState){
          if(state.loading==true){
            return SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
          }else if(state.data.cartItem!.isEmpty){
            return SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
          }else{
            return SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocal.subTotal.getString(context),
                    style: AppTextStyles.semiBold24P(),
                  ),
                  Text(
                    "₹${state.data.totalPrice}",
                    style: AppTextStyles.semiBold24P(),
                  ),
                ],
              ),
            );
          }
        }else{
          return SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}

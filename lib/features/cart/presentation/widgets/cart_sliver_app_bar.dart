import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';

class CartSliverAppBar extends StatelessWidget {
  const CartSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prev,curr)=> curr is CartFetchUserCartState,
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
          }
          else{
            return SliverAppBar(
              leading: PrimaryButton(
                onPress: () {
                  context.pushNamed(AppRoutes.selectPaymentMethod,
                      extra: context.read<CartBloc>());
                },
                title: "Proceed to Buy (${state.data.cartItem!.length} items)",
                titleStyle: AppTextStyles.medium18P(color: AppColors.white),
              ),
              leadingWidth: double.infinity,
              pinned: true,
            );
          }
        } else{
          return SliverAppBar(
            leading: PrimaryButton(
              onPress: () {

              },
              title: "Proceed to Buy (* items)",
              titleStyle: AppTextStyles.medium18P(color: AppColors.white),
            ),
            leadingWidth: double.infinity,
            pinned: true,
          );
        }

      },
    );
  }
}

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
    return SliverAppBar(
      leading: PrimaryButton(
        onPress: () {
          context.pushNamed(AppRoutes.paymentMethod);
        },
        title: "Proceed to Buy (${context.read<CartBloc>().items.length.toString()} items)",
        titleStyle: AppTextStyles.medium18P(color: AppColors.white),
      ),
      leadingWidth: double.infinity,
      pinned: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_item.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_total_amount_details.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/empty_cart.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/recommeded_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.read<NavigationBloc>().add(
              NavigationTabChangedEvent(index: 0),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
        title: Text(
          AppLocal.myCart.getString(context),
          style: AppTextStyles.semibold18P(),
        ),
        centerTitle: true,
      ),
      body: false
          ? EmptyCart()
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing_24,
                vertical:  AppDimensions.spacing_10
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocal.subTotal.getString(context),
                          style: AppTextStyles.semiBold24P(),
                        ),
                        Text(
                          "\$ Total Rupee",
                          style: AppTextStyles.semiBold24P(),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 10,),
                  ),
                  SliverAppBar(
                    leading:PrimaryButton(
                      title:"Proceed to Buy (* items)",
                      titleStyle: AppTextStyles.medium18P(color: AppColors.white),
                    ),
                    leadingWidth: double.infinity,
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: AppDimensions.spacing_10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CartItem(),
                        CartTotalAmountDetails(),
                        Text(
                          AppLocal.recommendedForYou.getString(context),
                          style: AppTextStyles.semibold18P(),
                        ),
                        RecommededItem(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}



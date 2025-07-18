import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_item.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_sliver_subtotal.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_total_amount_details.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/empty_cart.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/recommeded_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _cartBloc = context.read<CartBloc>();
    _cartBloc
      .add(CartFetchUserCartEvent(userId: "userId"));
  }
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
              padding: const EdgeInsets.only(
                left: AppDimensions.spacing_24,right: AppDimensions.spacing_24,
                top:  AppDimensions.spacing_10
              ),
              child: CustomScrollView(
                slivers: [
                  CartSliverSubtotal(),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 10,),
                  ),
                  CartSliverAppBar(),
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: AppDimensions.spacing_10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CartItem(),
                        CartTotalAmountDetails(),
                        Divider(radius: BorderRadius.circular(AppDimensions.radius_100),),
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



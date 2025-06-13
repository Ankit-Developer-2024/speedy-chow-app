import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/cart_item.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/empty_cart.dart';
import 'package:speedy_chow/features/cart/presentation/widgets/recommeded_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<NavigationBloc>().add(NavigationTabChangedEvent(index: 0));
        }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: AppDimensions.size_18,)),
        title: Text(AppLocal.myCart.getString(context),style: AppTextStyles.semibold18P(),),
        centerTitle: true,
      ),
      body: false ?
           EmptyCart()
          :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.spacing_14,
          children: [
            CartItem(),
            Text(AppLocal.recommendedForYou.getString(context),style: AppTextStyles.semibold18P(),),
            RecommededItem()
          ],
        ),
      ),
    );
  }
}

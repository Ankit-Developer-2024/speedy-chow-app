import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
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
      .add(CartFetchUserCartEvent());
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
      body: BlocConsumer<CartBloc,CartState>(
        listenWhen: (prev,curr)=> curr is  CartFetchUserCartState,
        listener: (context,state){
          if(state is CartFetchUserCartState){
            if(state.loading==true){
              customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
            }else{
              context.pop();
            }
          }
        },
        buildWhen: (prev,curr)=> curr is CartFetchUserCartState || curr is UpdateCartState ||curr is DeleteCartState ,
        builder: (context,state){
          if(state is CartFetchUserCartState){
            if(state.loading==true){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state.data.isEmpty){
              return EmptyCart();
            }else{
              return Padding(
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
                      child: SizedBox(height: 10,),
                    ),
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
              );
            }
          }else if(state is UpdateCartState || state is DeleteCartState){
            return context.read<CartBloc>().items.isEmpty ? EmptyCart() : Padding(
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
                    child: SizedBox(height: 10,),
                  ),
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
            );
          }
          else{
            return  SizedBox.shrink();
          }
        },)
    );
  }
}



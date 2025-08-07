import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';
import 'package:speedy_chow/features/product_details/presentation/bloc/product_detail_bloc.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key,required this.product});
  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1, 0.99),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [BoxShadow(color: AppColors.grey500.withAlpha(50),blurRadius: 5,offset: Offset(0, -1))],
        ),
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing_24,
            vertical: AppDimensions.spacing_2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<ProductDetailBloc,
                    ProductDetailState>(
                  listener: (context,state){
                    if(state is ProductDetailIncAndDecProductQuantityState){
                      if(state.loading==true){
                        customLoader(context: context);
                      }else {
                        context.pop();
                      }
                    }
                  },
                  buildWhen: (prev, curr) => curr is ProductDetailIncAndDecProductQuantityState,
                  builder: (context, state) {
                    if (state is ProductDetailIncAndDecProductQuantityState) {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                state.quantity <= 1
                                    ? null
                                    : context
                                    .read<ProductDetailBloc>()
                                    .add(ProductDetailIncAndDecProductQuantityEvent(
                                    quantity:
                                    state.quantity -
                                        1));
                              },
                              icon: Text(
                                '-',
                                style:
                                AppTextStyles.semiBold24P(),
                              )),
                          Text(state.quantity.toString(),
                              style: AppTextStyles.semibold18P()),
                          IconButton(
                              onPressed: () {
                                product.quantity! > state.quantity
                                    ? context
                                    .read<ProductDetailBloc>()
                                    .add(ProductDetailIncAndDecProductQuantityEvent(
                                    quantity:
                                    state.quantity +
                                        1))
                                    : null;
                              },
                              icon: Text("+",
                                  style: AppTextStyles
                                      .semiBold24P())),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Text(
                                '-',
                                style:
                                AppTextStyles.semiBold24P(),
                              )),
                          Text("1",
                              style: AppTextStyles.semibold18P()),
                          IconButton(
                              onPressed: () {
                                context.read<ProductDetailBloc>().add(
                                    ProductDetailIncAndDecProductQuantityEvent(
                                        quantity: 2));
                              },
                              icon: Text("+",
                                  style: AppTextStyles
                                      .semiBold24P())),
                        ],
                      );
                    }
                  },
                ),
                Text(
                  "${String.fromCharCode(8377)} ${discountPrice(product.price!, product.discountPercentage!)}",
                  style: AppTextStyles.semiBold24P(
                      color: AppColors.darkOrange),
                ),
              ],
            ),
            BlocConsumer<ProductDetailBloc, ProductDetailState>(
              listenWhen: (prev, curr) =>
              curr is ProductDetailAddProductInCartState,
              listener: (context, state) {
                if (state is ProductDetailAddProductInCartState) {
                  if (state.success) {
                    customSnackBar(context, bgColor: AppColors.primaryGreen, AppLocal.productSuccessfullyAdded.getString(context));
                  }else if(state.success==false && state.loading==false){
                    customSnackBar(context, bgColor: AppColors.primaryGreen, state.msg.isEmpty ? AppLocal.productSuccessfullyAdded.getString(context) : state.msg);
                  }
                }
              },
              buildWhen: (prev,curr)=> (curr is ProductDetailIncAndDecProductQuantityState || curr is ProductDetailAddProductInCartState),
              builder: (context, state) {
                if (state is ProductDetailAddProductInCartState) {
                  return Button(
                      onTap: () {
                        context.read<ProductDetailBloc>().isProductAlreadyAddedToCart ? customSnackBar(context, "Item already added in cart!",bgColor: AppColors.yellow800) : context.read<ProductDetailBloc>().add(
                            ProductDetailAddProductInCartEvent(
                                product: product));
                      },
                      child: state.loading
                          ? Center(
                        child: Loader(),
                      )
                          : Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: AppColors.white,
                          ),
                          Text(
                            context.read<ProductDetailBloc>().isProductAlreadyAddedToCart ? "Product Already added to cart!"  : AppLocal.addToCart.getString(context),
                            style:
                            AppTextStyles.semiBold14P(
                                color: AppColors.white),
                          )
                        ],
                      ));
                } else {
                  return Button(
                      onTap: () {
                        context.read<ProductDetailBloc>().isProductAlreadyAddedToCart ? customSnackBar(context, "Item already added in cart!",bgColor: AppColors.yellow800) : context.read<ProductDetailBloc>().add(
                            ProductDetailAddProductInCartEvent(
                                product: product));
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: AppColors.white,
                          ),
                          Text(
                           context.read<ProductDetailBloc>().isProductAlreadyAddedToCart ? "Product Already added to cart!"  : AppLocal.addToCart.getString(context),
                            style: AppTextStyles.semiBold14P(
                                color: AppColors.white),
                          )
                        ],
                      ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

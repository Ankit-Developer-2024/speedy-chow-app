import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/domain/enitites/product.dart';
import 'package:speedy_chow/features/product_details/presentation/bloc/product_detail_bloc.dart';

class HomeProductDetailView extends StatefulWidget {
  const HomeProductDetailView({super.key});

  @override
  State<HomeProductDetailView> createState() => _HomeProductDetailViewState();
}

class _HomeProductDetailViewState extends State<HomeProductDetailView> {
  late ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    super.initState();
    // final data = GoRouterState.of(context).extra as Map<String, dynamic>;
    // final product = data["product"] as Product;
    // print(product.name);
    _productDetailBloc = context.read<ProductDetailBloc>();
    _productDetailBloc
        .add(ProductDetailFetchProductEvent(productId: "23rjb32"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (context, state) {
            if (state is ProductDetailFetchProductState) {
              if (state.loading) {
                customLoaderDialog(context: context, title: "Processing...");
              } else if (state.success) {
                context.pop();
              }
            }
          },
          buildWhen: (prev, curr) => curr is ProductDetailFetchProductState,
          builder: (context, state) {
            if (state is ProductDetailFetchProductState &&
                state.success == true) {
              final product = state.data;
              return Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: AppDimensions.spacing_20),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height / 2 - 70,
                    child: Image.asset(
                      getLocalJpeg("burger"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppDimensions.spacing_38,
                        left: AppDimensions.spacing_10,
                        right: AppDimensions.spacing_10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton.outlined(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(Icons.arrow_back_ios_outlined)),
                        IconButton.outlined(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(Icons.favorite_outline_sharp))
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 2 + 100,
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.only(
                          left: AppDimensions.spacing_24,
                          right: AppDimensions.spacing_24,
                          top: AppDimensions.spacing_16),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(AppDimensions.radius_50),
                              topLeft:
                                  Radius.circular(AppDimensions.radius_50))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppDimensions.spacing_8,
                          children: [
                            Text(
                              product.name.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold27P(),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: AppTextStyles.medium20P(
                                        color: AppColors.darkOrange),
                                    children: [
                                  TextSpan(
                                      text:
                                          "${String.fromCharCode(8377)} ${product.price.toString()}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 1.5,
                                          color: AppColors.grey300)),
                                  WidgetSpan(
                                      child: SizedBox(
                                    width: AppDimensions.spacing_10,
                                  )),
                                  TextSpan(
                                      text:
                                          "${String.fromCharCode(8377)} ${discountPrice(product.price!, product.discountPercentage!)}")
                                ])),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.darkOrange.withAlpha(40),
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.radius_12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: AppDimensions.spacing_4,
                                    children: [
                                      Text(String.fromCharCode(8377),
                                          style: AppTextStyles.medium14P(
                                              color: AppColors.darkOrange)),
                                      Text("Free delivery",
                                          style: AppTextStyles.medium14P(
                                              color: AppColors.grey500)),
                                    ],
                                  ),
                                  Row(
                                    spacing: AppDimensions.spacing_4,
                                    children: [
                                      Icon(Icons.watch_later_outlined,
                                          color: AppColors.darkOrange),
                                      Text("20-30",
                                          style: AppTextStyles.medium14P(
                                              color: AppColors.grey500)),
                                    ],
                                  ),
                                  Row(
                                    spacing: AppDimensions.spacing_4,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.darkOrange,
                                      ),
                                      Text(
                                        product.rating.toString(),
                                        style: AppTextStyles.medium14P(
                                            color: AppColors.grey500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(AppLocal.description.getString(context),
                                style: AppTextStyles.semiBold24P()),
                            Text(
                              product.description.toString(),
                              style: AppTextStyles.regular16P(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //add to cart btn
                  Align(
                    alignment: Alignment(-1, 0.98),
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing_24,
                          vertical: AppDimensions.spacing_2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<ProductDetailBloc,
                                  ProductDetailState>(
                                buildWhen: (prev, curr) => curr
                                    is ProductDetailIncAndDecProductQuantityState,
                                builder: (context, state) {
                                  if (state
                                      is ProductDetailIncAndDecProductQuantityState) {
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
                            listenWhen: (prev,curr)=> curr is ProductDetailAddProductInCartState ,
                            listener: (context, state) {
                              if (state is ProductDetailAddProductInCartState) {
                                if (state.success) {
                                  customSnackBar(context, "Done");
                                }
                              }
                            },
                            buildWhen: (prev,curr)=> curr is ProductDetailAddProductInCartState,
                            builder:(context,state){
                              if(state is ProductDetailAddProductInCartState){
                                return Button(
                                    onTap: () {
                                      context.read<ProductDetailBloc>().add(
                                          ProductDetailAddProductInCartEvent(product: product ));
                                    },
                                    child:state.loading ? Center(child: Loader(),)  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: AppColors.white,
                                        ),
                                        Text(
                                          AppLocal.addToCart.getString(context),
                                          style: AppTextStyles.semiBold14P(
                                              color: AppColors.white),
                                        )
                                      ],
                                    ));
                              }else{
                                return Button(
                                    onTap: () {
                                      context.read<ProductDetailBloc>().add(
                                          ProductDetailAddProductInCartEvent(product: product ));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: AppColors.white,
                                        ),
                                        Text(
                                          AppLocal.addToCart.getString(context),
                                          style: AppTextStyles.semiBold14P(
                                              color: AppColors.white),
                                        )
                                      ],
                                    ));
                              }
                            } ,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

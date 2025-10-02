import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/domain/entities/product.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';
import 'package:speedy_chow/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:speedy_chow/features/product_details/presentation/widgets/add_to_cart_btn.dart';

class HomeProductDetailView extends StatefulWidget {
  const HomeProductDetailView({super.key});

  @override
  State<HomeProductDetailView> createState() => _HomeProductDetailViewState();
}

class _HomeProductDetailViewState extends State<HomeProductDetailView> {
  late ProductDetailBloc _productDetailBloc;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final product = GoRouterState.of(context).extra as Product;
      _productDetailBloc = context.read<ProductDetailBloc>();
      _productDetailBloc
        ..add(ProductDetailFetchProductEvent(productId: product.id.toString()))
        ..add(ProductQuantityUserCartFetchEvent(
            productId: product.id.toString()));
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 0),
          child: SizedBox(
            height: 10,
          )),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listenWhen: (prev, curr) => curr is ProductDetailFetchProductState,
          listener: (context, state) {
            if (state is ProductDetailFetchProductState) {
              if (state.loading) {
                customLoaderDialog(
                    context: context,
                    title: AppLocal.loading.getString(context));
              } else if (state.success) {
                context.pop();
              }
            }
          },
          buildWhen: (prev, curr) => curr is ProductDetailFetchProductState,
          builder: (context, state) {
            if (state is ProductDetailFetchProductState &&
                state.success == true) {
              final ProductDetails product = state.data;
              return Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: AppDimensions.spacing_20),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height / 2 - 70,
                    child: product.img != null
                        ? ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(
                                AppDimensions.radius_8),
                            child: CachedNetworkImage(
                                imageUrl: product.img!,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover))
                        : Image.asset(
                            getLocalJpeg("burger"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppDimensions.spacing_38,
                        left: AppDimensions.spacing_10,
                        right: AppDimensions.spacing_10),
                    child: IconButton.outlined(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                        )),
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
                                  product.discountPercentage == 0
                                      ? TextSpan()
                                      : TextSpan(
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
                                          "${String.fromCharCode(8377)} ${product.discountedPrice.toString()}")
                                ])),
                            product.quantity != null && product.quantity! <= 0
                                ? Text(
                                    "Out of stock",
                                    style: AppTextStyles.medium16P(
                                        color: AppColors.errorRed),
                                  )
                                : Text(
                                    "In stock",
                                    style: AppTextStyles.medium16P(
                                        color: AppColors.primaryGreen),
                                  ),
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
                                          style: AppTextStyles.medium20P(
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
                  AddToCartBtn(product: product)
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';

class HomeProductsView extends StatelessWidget {
  const HomeProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: AppDimensions.spacing_24,
        right: AppDimensions.spacing_24,
        left: AppDimensions.spacing_24,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(childCount: 10, (context, index) {
          return InkWell(
            onTap: (){
              context.pushNamed(AppRoutes.productDetails,extra:context.read<HomeBloc>());
            },
            child: Container(
              padding: EdgeInsets.all(AppDimensions.spacing_8),
              decoration: BoxDecoration(
                  color: AppColors.grey50.withAlpha(80),
                borderRadius: BorderRadius.circular(AppDimensions.radius_8)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppDimensions.spacing_8,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(AppDimensions.radius_8),
                          child: Image.asset(getLocalJpeg("burger"),width: MediaQuery.sizeOf(context).width/2-45,)),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton.filledTonal(
                          onPressed: () {},
                           style: ButtonStyle(
                             backgroundColor: WidgetStateProperty.all(AppColors.white)
                           ),
                          icon: Icon(
                            Icons.favorite_outline_sharp,
                            color: AppColors.red1000,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("Burger Name sdfs df s",style: AppTextStyles.medium18P(),overflow: TextOverflow.ellipsis,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_8,
                    children: [
                    Icon(Icons.star,color: AppColors.darkOrange,),
                    Text("Ratings",style: AppTextStyles.medium18P(),)
                  ],),
                  RichText(text: TextSpan(
                    style: AppTextStyles.medium20P(color: AppColors.darkOrange),
                    children: [
                      TextSpan(text: "\$"),
                      WidgetSpan(child: SizedBox(width: AppDimensions.spacing_8,)),
                      TextSpan(text: "Price"),
                    ]
                  ))
                ],
              ),
            ),
          );
        }),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.spacing_10,
          mainAxisSpacing: AppDimensions.spacing_10,
          mainAxisExtent: 225
        ),
      ),
    );
  }
}

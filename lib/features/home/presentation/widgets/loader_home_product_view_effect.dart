import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class LoaderHomeProductViewEffect extends StatelessWidget {
  const LoaderHomeProductViewEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 4,
            (context, index) {
          return Shimmer.fromColors(
              baseColor: AppColors.grey100,
              highlightColor: AppColors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                ),
              )
          );
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.spacing_10,
          mainAxisSpacing: AppDimensions.spacing_10,
          mainAxisExtent: 225
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class LoaderCategoryEffect extends StatelessWidget {
  const LoaderCategoryEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.grey100,
        highlightColor: AppColors.white,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context,index){
            return Container(
              width: AppDimensions.size_100,
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(AppDimensions.radius_8),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: AppDimensions.spacing_20,
            );
          },
        )
    );
  }
}

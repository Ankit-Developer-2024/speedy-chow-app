import 'package:flutter/cupertino.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class HomeProductsView extends StatelessWidget {
  const HomeProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only( top:AppDimensions.spacing_24,right:AppDimensions.spacing_24,left:AppDimensions.spacing_24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) {
          return Container(
            width: 100,
            height: 100,
            color: AppColors.darkOrange,
          );
        }),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.spacing_10,
          mainAxisSpacing: AppDimensions.spacing_10,
        ),
      ),
    );
  }
}

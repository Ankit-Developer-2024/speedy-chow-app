import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class HAxisLine extends StatelessWidget {
  const HAxisLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: AppDimensions.size_1,
      decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.circular(AppDimensions.radius_100)
      ),
    );
  }
}

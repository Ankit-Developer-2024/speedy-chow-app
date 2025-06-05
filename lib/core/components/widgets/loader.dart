
import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class Loader extends StatelessWidget {
  const Loader({super.key,this.height , this.width, this.strokeWidth,this.color});
  final double? width;
  final double? height;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? AppDimensions.size_28,
        height: height ?? AppDimensions.size_28,
        child: CircularProgressIndicator(
          color:color ?? AppColors.white,
          strokeWidth: strokeWidth ?? 4,));
  }
}

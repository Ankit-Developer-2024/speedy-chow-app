import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.width,
  });
  final VoidCallback onTap;
  final Widget child;
  final double? borderRadius;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Ink(decoration: BoxDecoration(
        color: color ?? AppColors.darkOrange,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppDimensions.radiusSmall,
        ),
      ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusSmall,
          ),
          child: Container(
            width: width ?? double.maxFinite ,
            padding: padding ?? EdgeInsets.symmetric(vertical:  AppDimensions.spacing_16),

            child: child,
          ),
        ),
      ),
    );
  }
}

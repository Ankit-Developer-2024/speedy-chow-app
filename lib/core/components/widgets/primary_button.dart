import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPress;
  final bool isEnabled;
  final String? title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final TextStyle? titleStyle;

  /// defaults to giving 10 px
  final double leftIconTitleSpacing;

  /// defaults to giving 10 px
  final double rightIconTitleSpacing;

  const PrimaryButton({
    super.key,
    this.title,
    this.onPress,
    this.isEnabled = true,
    this.leftIcon,
    this.rightIcon,
    this.padding,
    this.backgroundColor = AppColors.darkOrange,
    this.disabledBackgroundColor = AppColors.grey300,
    this.titleStyle,
    this.leftIconTitleSpacing = 10,
    this.rightIconTitleSpacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPress : null,
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isEnabled ? backgroundColor : disabledBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leftIcon != null) leftIcon!,
            if (title != null)
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: leftIcon != null ? leftIconTitleSpacing : 0,
                    right: rightIcon != null ? rightIconTitleSpacing : 0,
                  ),
                  child: Text(
                    title!,
                    style: titleStyle ??
                        AppTextStyles.regular14P(
                          color: AppColors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (rightIcon != null) rightIcon!,
          ],
        ),
      ),
    );
  }
}

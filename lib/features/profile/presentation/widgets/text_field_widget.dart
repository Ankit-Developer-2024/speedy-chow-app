import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.onChanged,
    this.validator,
    this.enabled,
    this.prefixIcon,
    this.keyboardType,
  });
  final String title;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool? enabled;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimensions.spacing_8,
      children: [
        Text(title, style: AppTextStyles.medium16P()),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:keyboardType ,
          style: AppTextStyles.medium14P(),
          decoration: InputDecoration(
            hintText: title,
            enabled: enabled ?? true,
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints(minWidth: 20)


          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

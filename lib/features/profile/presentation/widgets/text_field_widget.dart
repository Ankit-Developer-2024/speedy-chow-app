import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key,required this.title,required this.controller,this.onChanged,this.validator});
  final String title;
  final TextEditingController controller;
  final String Function(String?)?  validator;
  final Function(String)?  onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimensions.spacing_8,
      children: [
        Text(title,style: AppTextStyles.medium16P(),),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: title
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

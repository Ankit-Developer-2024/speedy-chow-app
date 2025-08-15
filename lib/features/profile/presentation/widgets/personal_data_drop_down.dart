import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class PersonalDataDropDown extends StatelessWidget {
  const PersonalDataDropDown({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimensions.spacing_8,
      children: [
        Text(title, style: AppTextStyles.medium16P()),
        DropdownMenu(
            width:  MediaQuery.sizeOf(context).width * .6,
            controller: controller,
            hintText: "Select Gender",
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "Male", label: "Male"),
              DropdownMenuEntry(value: "Female", label: "Female"),
              DropdownMenuEntry(value: "Transgender", label: "Transgender"),
            ])
      ],
    );
  }
}

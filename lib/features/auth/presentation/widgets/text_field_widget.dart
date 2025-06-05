import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isObscureText,
    this.onTap,
    this.icon,
    this.onValidate
  });
  final TextEditingController controller;
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool? isObscureText;
  final FormFieldValidator<String>?  onValidate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isObscureText ?? false,
      decoration: InputDecoration(
        hintText: label,
        label: Text(label),
        border: OutlineInputBorder(),
        suffixIcon: icon != null
            ? IconButton(onPressed: onTap, icon: Icon(icon))
            : null,
      ),
      validator: onValidate,
    );
  }
}

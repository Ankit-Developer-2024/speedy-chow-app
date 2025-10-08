import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isObscureText,
    this.onTap,
    this.icon,
    this.onValidate,
    this.onChange,
    this.focusNode
  });
  final TextEditingController controller;
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool? isObscureText;
  final FormFieldValidator<String>?  onValidate;
  final Function(String)? onChange;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isObscureText ?? false,
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        hintText: label,
        label: Text(label),
        border: OutlineInputBorder(),
        errorMaxLines: 2,
        suffixIcon: icon != null
            ? IconButton(onPressed: onTap, icon: Icon(icon))
            : null,
      ),
      validator: onValidate,
      onChanged: onChange,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final InputDecoration? decoration;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        enabled: enabled,

        decoration: InputDecoration(
          hintText: hintText,
          enabled: false,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 22,
          ),
        ),
      ),
    );
  }
}

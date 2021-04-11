import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final String Function(String) validator;
  final Color textColor;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final int maxLength;
  final int maxLines;
  final Color borderColor;
  final BorderRadius borderRadius;

  const CustomTextFormField({
    this.icon,
    this.hintText,
    this.controller,
    this.enabled = true,
    this.validator,
    this.textColor,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.maxLength, this.maxLines = 1, this.borderColor = Colors.white, this.borderRadius = const BorderRadius.all(Radius.circular(5)),

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 10.0,
            offset: Offset(2, 3),
          ),
        ],
        // color: ThemeColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        onChanged: onChanged,
        enabled: enabled,
        validator: validator,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
        ),
        controller: controller,
        readOnly: !enabled,
        keyboardType: keyboardType,
maxLines: maxLines,
        decoration: InputDecoration(

          counterText: "",
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          contentPadding: EdgeInsets.all(16),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: borderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: ThemeColors.primary),
          ),
        ),
      ),
    );
  }
}

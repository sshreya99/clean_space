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

  const CustomTextFormField({
    this.icon,
    this.hintText,
    this.controller,
    this.enabled = true,
    this.validator,
    this.textColor, this.obscureText = false, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration:  BoxDecoration(
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        validator: validator,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
        ),
        controller: controller,
        readOnly: !enabled,

        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          contentPadding: EdgeInsets.all(16),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: ThemeColors.primary),
          ),
        ),
      ),
    );
  }
}

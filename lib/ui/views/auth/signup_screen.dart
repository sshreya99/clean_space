import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 120,
                ),
                SizedBox(height: 20),
                Text(
                  "Clean Space",
                  style: TextStyle(fontSize: 29),
                ),
                SizedBox(height: 50),
                CustomTextFormField(
                  hintText: "Name",
                ),
                CustomTextFormField(
                  hintText: "Email",
                ),
                CustomTextFormField(
                  hintText: "Phone Number",
                ),
                CustomTextFormField(
                  hintText: "Password",
                  obscureText: true,
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                CustomTextFormField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  // suffixIcon: GestureDetector(
                  //   child: Icon(
                  //     Icons.remove_red_eye_outlined,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                SizedBox(height: 20),
                CustomRoundedRectangularButton(
                  onPressed: () {},
                  color: ThemeColors.primary,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, Routes.signinScreen),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      text: "Already have an account?  ",
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.primary),
                          text: "Log in",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

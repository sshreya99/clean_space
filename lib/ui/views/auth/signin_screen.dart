import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
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
                SizedBox(height: 70),
                CustomTextFormField(
                  hintText: "Email",
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
                SizedBox(height: 20),
                CustomRoundedRectangularButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, Routes.homeScreen),
                  color: ThemeColors.primary,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height:10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.forgotPasswordSendVerificationScreen),

                  style: ButtonStyle(
                  ),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: ThemeColors.primary),
                  ),
                ),
                SizedBox(height:50),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, Routes.signUpScreen),
                  child: RichText(text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    text: "Don't have an account?  ",
                    children: [
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.primary),
                        text: "Sign Up",
                      )
                    ],

                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

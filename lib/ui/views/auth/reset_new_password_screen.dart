import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class ResetNewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black,),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Forgot Password",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/forgot_pass.png",
                  width: 100,
                ),
                SizedBox(height: 60),
                Text(
                  "Create New Password",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your new password and confirm it\nmake sure it is remembered",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 60),
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
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomRoundedRectangularButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  color: ThemeColors.primary,
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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

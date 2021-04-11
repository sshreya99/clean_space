import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSendVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.black,),
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
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your registered email below to receive\npassword reset instruction ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 60),
                CustomTextFormField(
                  hintText: "Email",
                ),
                SizedBox(height: 20),
                CustomRoundedRectangularButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.resetNewPasswordScreen);
                  },
                  color: ThemeColors.primary,
                  child: Text(
                    "Send",
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

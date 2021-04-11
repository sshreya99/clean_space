import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/ui_helpers.dart';
import 'package:clean_space/ui/utils/validators/auth_validators.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSendVerificationScreen extends StatefulWidget {
  @override
  _ForgotPasswordSendVerificationScreenState createState() =>
      _ForgotPasswordSendVerificationScreenState();
}

class _ForgotPasswordSendVerificationScreenState
    extends State<ForgotPasswordSendVerificationScreen> {
  final _emailTextEditingController = TextEditingController();
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final _authService = locator<AuthenticationService>();

  bool isLoading = false;
  bool hasVerificationSent = false;

  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
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
                    fontSize: 22,
                  ),
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
                Form(
                  key: _forgotPasswordFormKey,
                  child: CustomTextFormField(
                    controller: _emailTextEditingController,
                    validator: AuthValidators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomRoundedRectangularButton(
                        onPressed: _performSendForgotPasswordVerification,
                        color: ThemeColors.primary,
                        child: Text(
                          !hasVerificationSent ? "Send" : "Resend",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                SizedBox(height: 20),
                if (hasVerificationSent)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Verification Link has been sent to ${_emailTextEditingController.text}.\nYou can reset password there and come back here to login.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                if (hasVerificationSent)
                  TextButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    child: Text(
                      "Login Now",
                      style: TextStyle(color: ThemeColors.primary),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _performSendForgotPasswordVerification() async {
    if (!_forgotPasswordFormKey.currentState.validate()) return;

    final email = _emailTextEditingController.text.trim();

    try {
      setState(() => isLoading = true);
      setState(() => hasVerificationSent = false);
      await _authService.sendForgotPasswordEmail(email);
      setState(() => isLoading = false);
      setState(() => hasVerificationSent = true);

      // Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      showErrorDialog(context, errorMessage: e.message);
    }
  }
}

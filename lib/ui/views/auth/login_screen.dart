import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/utils/ui_helpers.dart';
import 'package:clean_space/ui/utils/validators/auth_validators.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final _authService = locator<AuthenticationService>();

  bool isPasswordVisible = false;
  bool isLoading = false;

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
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailTextEditingController,
                        validator: (value) => AuthValidators.validateEmpty(value, "Email or Username"),
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email or Username",
                      ),
                      CustomTextFormField(
                        controller: _passwordTextEditingController,
                        hintText: "Password",
                        validator: AuthValidators.validatePassword,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => isPasswordVisible = !isPasswordVisible),
                          splashRadius: 25,
                          icon: Icon(
                            !isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomRoundedRectangularButton(
                        onPressed: _performLogin,
                        color: ThemeColors.primary,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                      context, Routes.forgotPasswordSendVerificationScreen),
                  style: ButtonStyle(),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: ThemeColors.primary),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, Routes.signUpScreen),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      text: "Don't have an account?  ",
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.primary),
                          text: "Sign Up",
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

  _performLogin() async {
    if (!_loginFormKey.currentState.validate()) return;

    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();

    try {
      setState(() => isLoading = true);
      await _authService.signInWithEmailAndPassword(email, password);
      setState(() => isLoading = false);

      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      showErrorDialog(context, errorMessage: e.message);
    }
  }
}

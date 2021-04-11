import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/ui_helpers.dart';
import 'package:clean_space/ui/utils/validators/auth_validators.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _phoneNumberTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  final _authService = locator<AuthenticationService>();
  final _userProfileService = locator<UserProfileService>();

  bool isPasswordVisible = false;
  bool isLoading = false;

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
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _usernameTextEditingController,
                        hintText: "Username",
                        validator: (value) =>
                            AuthValidators.validateEmpty(value, "Username"),
                      ),
                      CustomTextFormField(
                        controller: _emailTextEditingController,
                        validator: AuthValidators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                      ),
                      CustomTextFormField(
                        controller: _phoneNumberTextEditingController,
                        hintText: "Phone Number",
                        validator: AuthValidators.validatePhone,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
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
                      CustomTextFormField(
                        hintText: "Confirm Password",
                        validator: (value) =>
                            AuthValidators.validateConfirmPassword(
                                value, _passwordTextEditingController.text),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        // suffixIcon: IconButton(
                        //   onPressed: () => setState(
                        //           () => isPasswordVisible = !isPasswordVisible),
                        //   splashRadius: 25,
                        //   icon: Icon(
                        //     !isPasswordVisible
                        //         ? Icons.visibility_off_outlined
                        //         : Icons.visibility_outlined,
                        //     color: Colors.grey,
                        //     size: 24,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomRoundedRectangularButton(
                  onPressed: _performSignUp,
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
                      context, Routes.loginScreen),
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

  _performSignUp() async {
    if (!_signUpFormKey.currentState.validate()) return;

    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();
    final userName = _usernameTextEditingController.text.trim();
    final phoneNumber = _phoneNumberTextEditingController.text.trim();

    try {
      setState(() => isLoading = true);
      if (await _userProfileService.isUsernameAlreadyTaken(userName)) {
        throw Failure(
          message:
              "Username is already taken, please choose different username.",
        );
      }

      UserProfile userProfile = UserProfile(
        username: userName,
        email: email,
        phone: phoneNumber,
      );
      await _authService.signUpWithEmailAndPassword(userProfile, password);
    setState(() => isLoading = false);

    Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      showErrorDialog(context, errorMessage: e.message);
    }
  }
}

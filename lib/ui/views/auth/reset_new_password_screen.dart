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

class ResetNewPasswordScreen extends StatefulWidget {
  @override
  _ResetNewPasswordScreenState createState() => _ResetNewPasswordScreenState();
}

class _ResetNewPasswordScreenState extends State<ResetNewPasswordScreen> {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final _currentPasswordTextEditingController = TextEditingController();
  final _newPasswordTextEditingController = TextEditingController();
  final _confirmNewPasswordTextEditingController = TextEditingController();

  final _changePassFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool showPassword = false;

  void changePassword() async {
    if (!_changePassFormKey.currentState.validate()) return;
    try {
      setState(() {
        isLoading = true;
      });
      final currentUserProfile =
          await _authenticationService.currentUserProfile;
      await _authenticationService.signInWithEmailAndPassword(
          currentUserProfile.email,
          _currentPasswordTextEditingController.text.trim());
      await _authenticationService
          .changePassword(_newPasswordTextEditingController.text);
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    } on Failure catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, errorMessage: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Change Password",
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
                Form(
                  key: _changePassFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _currentPasswordTextEditingController,
                        hintText: "Current Password",
                        obscureText: !showPassword,
                        validator: (value) => AuthValidators.validatePassword(value),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => showPassword = !showPassword),
                          child: Icon(
                            showPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off ,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: _newPasswordTextEditingController,
                        hintText: "New Password",
                        obscureText: !showPassword,
                        validator: (value) => AuthValidators.validatePassword(value),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => showPassword = !showPassword),
                          child: Icon(
                              showPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off ,
                              color: Colors.grey,
                            ),
                          ),

                      ),
                      CustomTextFormField(
                        controller: _confirmNewPasswordTextEditingController,
                        hintText: "Confirm New Password",
                        validator: (value) => AuthValidators.validateConfirmPassword(
                            value, _newPasswordTextEditingController.text),
                        obscureText: !showPassword,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => showPassword = !showPassword),
                          child: Icon(
                            showPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off ,
                            color: Colors.grey,
                          ),
                        ),


                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),

                isLoading ? Center(child: CircularProgressIndicator()) :CustomRoundedRectangularButton(
                  onPressed: changePassword,
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

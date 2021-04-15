import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/validators/auth_validators.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final UserProfile userProfile;

  SettingsScreen({this.userProfile});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final _newPasswordTextEdititingController = TextEditingController();

  final _confirmNewPasswordTextEdititingController = TextEditingController();

  final _changePassFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  void changePassword() async {
    if (!_changePassFormKey.currentState.validate()) return;
    setState(() {
      isLoading = true;
    });
    await _authenticationService
        .changePassword(_newPasswordTextEdititingController.text);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }
  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: Form(
              key: _changePassFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomTextFormField(
                      controller: _newPasswordTextEdititingController,
                      validator: (value) =>
                          AuthValidators.validatePassword(value),
                      hintText: "Enter current Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFormField(
                      controller: _newPasswordTextEdititingController,
                      validator: (value) =>
                          AuthValidators.validatePassword(value),
                      hintText: "Enter new password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFormField(
                      controller: _confirmNewPasswordTextEdititingController,
                      validator: (value) =>
                          AuthValidators.validateConfirmPassword(value,
                              _newPasswordTextEdititingController.text),
                      hintText: "Confirm Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : CustomRoundedRectangularButton(
                        // width: 100,
                        onPressed: changePassword,
                        color: ThemeColors.primary,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(
          children: [
            CustomRoundedRectangularButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.editProfileView,
                    arguments: EditProfileViewArguments(
                      userProfile: widget.userProfile,
                    ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.lightBlueAccent,
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text("Edit Profile")),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
              color: Colors.white,
            ),
            SizedBox(height: 20),
            CustomRoundedRectangularButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Colors.deepPurpleAccent,
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text("Manage Notification")),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12,
                    child: Text(
                      "3",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
              color: Colors.white,
            ),
            SizedBox(height: 20),
            CustomRoundedRectangularButton(
              // onPressed: _showBottomSheet,
              onPressed: () {
                Navigator.pushNamed(context, Routes.resetNewPasswordScreen);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.vpn_key,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text("Change Password")),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
              color: Colors.white,
            ),
            SizedBox(height: 20),
            CustomRoundedRectangularButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text("Terms And Conditions")),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
              color: Colors.white,
            ),
            SizedBox(height: 20),
            CustomRoundedRectangularButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.update, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(child: Text("Updates")),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
              color: Colors.white,
            ),
            SizedBox(height: 50),
            Text(
              "Clean Space v1.0.0",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

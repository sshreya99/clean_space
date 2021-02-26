import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/components/already_have_an_account_acheck.dart';
import 'package:clean_space/ui/components/rounded_button.dart';
import 'package:clean_space/ui/components/text_field_container.dart';
import 'package:clean_space/ui/constants.dart';
import 'package:clean_space/ui/views/auth/Signup/components/or_divider.dart';
import 'package:clean_space/ui/views/auth/Signup/components/social_icon.dart';
import 'package:clean_space/ui/views/auth/signin/signin_screen.dart';
import 'package:clean_space/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Username is required!";
                          }

                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email is required!";
                          }

                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value.isNotEmpty && value.length != 10) {
                            return "Phone Number must be of 10 digits.";
                          }
                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required!";
                          } else if (value.length < 6) {
                            return "Password should be atleast of 6 characters.";
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Confirm Password is required!";
                          } else if (value != _passwordController.text) {
                            return "Both Password Should be same.";
                          }

                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                : RoundedButton(
                    text: "SIGNUP",
                    onPressed: () async {
                      // 1. fetch - done
                      // 2. validate
                      if (!_formKey.currentState.validate()) return;

                      // 3. signup func call
                      UserProfile userProfile = UserProfile(
                        email: _emailController.text,
                        username: _usernameController.text,
                        phone: _phoneController.text,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await _authenticationService.signUpWithEmailAndPassword(
                            userProfile, _passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } on Failure catch (e) {
                        // 5. if error -> show error message
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text("Error Occurred!"),
                            content: Text(e.message),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          ),
                        );
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SigninScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

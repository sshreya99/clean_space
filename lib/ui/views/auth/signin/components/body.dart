import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/components/already_have_an_account_acheck.dart';
import 'package:clean_space/ui/components/rounded_button.dart';
import 'package:clean_space/ui/components/text_field_container.dart';
import 'package:clean_space/ui/views/auth/Signup/signup_screen.dart';
import 'package:clean_space/ui/views/auth/signin/components/background.dart';
import 'package:clean_space/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clean_space/utils/extensions/string_extension.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _emailController,
                        validator: (String value) {
                          value.isEmail;
                          if (value.isEmpty) {
                            return "Email is required!";
                          } else if (!value.isEmail) {
                            return "Please enter valid email!";
                          }
                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Your Email",
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required!";
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : RoundedButton(
                            text: "SIGNIN",
                            onPressed: () async {
                              // 1. fetch - done
                              // 2. validate
                              if (!_formKey.currentState.validate()) return;
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await _authenticationService
                                    .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (_) => false,
                                );
                              } on Failure catch (e) {
                                // 5. if error -> show error message
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Error Occurred!"),
                                    content: Text(e.message),
                                    actions: [
                                      TextButton(
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
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

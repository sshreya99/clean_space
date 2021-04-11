import 'package:clean_space/app/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';

class OnBoardingScreen extends StatelessWidget {
  final _pageDecoration = PageDecoration(
    pageColor: Color(0xff303790),
    bodyTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    imagePadding: EdgeInsets.only(left: 20, right: 20, top: 40),
    imageFlex: 5,
    bodyFlex: 4,
    footerPadding: EdgeInsets.only(top: 50, left: 10, right: 10),
  );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      dotsDecorator: DotsDecorator(
        color: Colors.white60,
        activeColor: Colors.white,
      ),
      globalBackgroundColor: Color(0xff303790),
      pages: [
        PageViewModel(
          decoration: _pageDecoration,
          title: "Login",
          body:
              "Register with us and help your city\nace the cleanliness ranking",
          image: Image.asset("assets/images/on_boarding_1.png"),
        ),
        PageViewModel(
          decoration: _pageDecoration,
          title: "Post",
          body: "Click a picture of the concerned\nissue, post a complaint",
          image: Image.asset("assets/images/on_boarding_2.png"),
        ),
        PageViewModel(
          decoration: _pageDecoration,
          title: "Map",
          body: "Identify problems easily with our\ncolour coded map",
          image: Image.asset("assets/images/on_boarding_3.png"),
        ),
        PageViewModel(
          decoration: _pageDecoration,
          title: "Survey",
          body: "Provide suggestions and feedback\nby filling out the survey",
          image: Image.asset("assets/images/on_boarding_4.png"),
          footer: Column(
            children: [
              CustomRoundedRectangularButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signUpScreen);
                },
                child: Text(
                  "Signup",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.homeScreen);
                },
                child: Text(
                  "Skip for now",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
      onDone: () {
        Navigator.pushReplacementNamed(context, Routes.signinScreen);
      },
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(color: Colors.white)),
      done: const Text("Done",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 180,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Cleanspace",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/splash_bottom.png",
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

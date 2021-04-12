import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final UserProfile userProfile;

 SettingsScreen({this.userProfile});

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();



  @override
  Widget build(BuildContext context) {
    print(userProfile.username);
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
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(
          children: [
            CustomRoundedRectangularButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.editProfileView,
                    arguments: EditProfileViewArguments(
                      userProfile: userProfile,
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
              onPressed: () {},
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

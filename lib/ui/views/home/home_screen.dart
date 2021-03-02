import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/views/startup/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Dialog show
              // logout
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    FlatButton(
                      onPressed: () async {
                        //  logout
                        await _authenticationService.signOut();

                        // Welcome Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
        title: Text("Home Screen"),
      ),
      body: Center(
        child: FutureBuilder<UserProfile>(
            future: _authenticationService.currentUserProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Text(
                    "${snapshot.data.email} : ${snapshot.data.createdAt}");
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

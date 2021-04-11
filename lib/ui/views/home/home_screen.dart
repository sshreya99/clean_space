import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder<UserProfile>(
              future: _authenticationService.currentUserProfile,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.profileScreen,
                    arguments:
                        ProfileScreenArguments(userProfile: snapshot.data),
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Dialog show
              // logout
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        //  logout
                        await _authenticationService.signOut();
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, Routes.startupScreen);
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
                    "${snapshot.data.email} : ${snapshot.data.username}");
              return Text("Not Logged in");
            }),
      ),
    );
  }
}

import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/auth/login_screen.dart';
import 'package:clean_space/ui/views/home/feed_view.dart';
import 'package:clean_space/ui/views/profile/profile_screen.dart';
import 'package:clean_space/ui/views/rank/rank_view.dart';
import 'package:clean_space/ui/views/startup/startup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  int _currentIndex = 0;

  UserProfile _userProfile;

  @override
  void initState() {
    fetchUserProfile();
    super.initState();
  }

  Future<void> fetchUserProfile() async {
    _userProfile = await _authenticationService.currentUserProfile;
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 120,
          color: Colors.black87,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.createPostScreen,
                          arguments:
                              CreatePostScreenArguments(isComplaint: true),
                        );
                      },
                      child: Text(
                        "Add Complaint",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.createPostScreen,
                        );
                      },
                      child: Text(
                        "Add Post",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<UserProfile>(
            future: _authenticationService.currentUserProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return [
                  FeedView(),
                  RankView(),
                  FeedView(),
                  FutureBuilder<UserProfile>(
                      future: _authenticationService.currentUserProfile,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return ProfileScreen(
                          userProfile: snapshot.data,
                          isCurrentProfile: true,
                        );
                      }),
                ][_currentIndex];
              return Text("Not Logged in");
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff678E26),
                ThemeColors.primary,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Icon(
            Icons.add,
          ),
        ),
        backgroundColor: ThemeColors.primary,
        elevation: 15,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 20,
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavBarItem(Icons.home, 0),
              buildNavBarItem(Icons.emoji_events, 1),
              buildNavBarItem(null, -1),
              buildNavBarItem(Icons.notifications, 2),
              buildNavBarItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return icon != null
        ? IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = index;
              });
            },
            icon: Icon(
              icon,
              size: 25,
              color: index == _currentIndex
                  ? ThemeColors.primary
                  : Colors.grey[700],
            ),
          )
        : Container();
  }
}

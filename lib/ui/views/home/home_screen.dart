import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/views/home/feed_view.dart';
import 'package:clean_space/ui/views/profile/profile_screen.dart';
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

  final List<Widget> _children = [
    FeedView(),
    FeedView(),
    FeedView(),
    ProfileScreen(),
  ];
  _showPopUpMenu(){
    PopupMenu menu = PopupMenu(
        items: [
          MenuItem(title: "Add Complaint", image: Icon(Icons.book_online)),
          MenuItem(title: "Add Post", image: Icon(Icons.post_add_rounded)),
        ],
      onClickMenu: (MenuItemProvider item){
          if (item.menuTitle == "Add Complaint"){
            Navigator.pushReplacementNamed(context, Routes.complaintsView);
          }
          else if (item.menuTitle == "Add Post"){
            Navigator.pushReplacementNamed(context, Routes.postView);
          }
      }
    );
    menu.show();
  }
  _showBottomSheet() {
    showModalBottomSheet(context: context,
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

                        Navigator.pushReplacementNamed(context, Routes.complaintsView);
                      },
                      child: Text("Add Complaint",style: TextStyle(color: Colors.white, fontSize: 18),)),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.postView);
                      },
                      child: Text("Add Post",style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                if (snapshot.hasData) return _children[_currentIndex];
                return Text("Not Logged in");
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed:_showBottomSheet,
            child: Icon(
              Icons.add,
            ),
            backgroundColor: Colors.grey[900],
            elevation: 15,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
              )
            ],
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.search, 1),
            buildNavBarItem(null, -1),
            buildNavBarItem(Icons.notifications, 2),
            buildNavBarItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }
  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 45,
        child: icon != null
            ? Icon(
          icon,
          size: 25,
          color: index == _currentIndex
              ? Colors.black
              : Colors.grey[700],
        )
            : Container(),
      ),
    );
  }
}

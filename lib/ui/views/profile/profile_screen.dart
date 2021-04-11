import 'dart:ui';

import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController controller;
  int currentTabIndex = 0;

  @override
  void initState() {
    controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentTabIndex,
    );

    controller.addListener(() {
      setState(() {
        currentTabIndex = controller.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            image: DecorationImage(
                              image: AssetImage("assets/images/demo_post.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // child: ClipRRect(
                          //   child: BackdropFilter(
                          //     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          //     child: new Container(
                          //       height: 150,
                          //       color: Colors.transparent,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                      AppBar(
                        elevation: 0,
                        leading: BackButton(),
                        backgroundColor: Colors.transparent,
                        actions: [
                          IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.settingsScreen)),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 130),
                        // height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 90),
                            Text("Rohan_Sharma_11",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text("Manjalpur-darbarchowkli",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                "This garden greenery and This garden greenery is Amazing and the garden is so clean...",
                                style: TextStyle(fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    shape: CircleBorder(),
                                    minWidth: 50,
                                    height: 50,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.chat,
                                      color: ThemeColors.primary,
                                    ),
                                    elevation: 3,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      color: ThemeColors.primary,
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      elevation: 3,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  MaterialButton(
                                    onPressed: () {},
                                    shape: CircleBorder(),
                                    minWidth: 50,
                                    height: 50,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.share,
                                      color: ThemeColors.primary,
                                    ),
                                    elevation: 3,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      _buildProfileAvatar(),
                    ],
                  ),
                ],
              ),
            )
          ];
        },
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                controller: controller,
                labelColor: Colors.black,
                indicatorColor: ThemeColors.primary,
                tabs: [
                  Tab(
                    child: Text(
                      "13k Posts",
                      style: TextStyle(
                        fontWeight: currentTabIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "1k Complaints",
                      style: TextStyle(
                        fontWeight: currentTabIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    GridView.count(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        50,
                        (index) =>
                            Image.asset("assets/images/avatar_demo.jpeg"),
                      ),
                    ),
                    GridView.count(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        50,
                        (index) => Image.asset("assets/images/demo_post.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/images/avatar_demo.jpeg"),
        // child: Image.asset(),
        radius: 60,
      ),
    );
  }
}

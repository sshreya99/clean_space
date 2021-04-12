import 'dart:ui';

import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/complaints_service.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/widgets/feed_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  final bool isCurrentProfile;

  ProfileScreen({@required this.userProfile, this.isCurrentProfile = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController controller;
  int currentTabIndex = 0;

  final PostsService _postsService = locator<PostsService>();
  final ComplaintsService _complaintsService = locator<ComplaintsService>();

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

    if (widget.userProfile == null) {}
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
                        leading: widget.isCurrentProfile ? null : BackButton(),
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        actions: widget.isCurrentProfile
                            ? [
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    Routes.settingsScreen,
                                  ),
                                ),
                              ]
                            : [],
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
                            Text(widget?.userProfile?.username ?? "",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text(widget?.userProfile?.location?.area ?? "",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                widget.userProfile.bio ?? "",
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
                      "Posts",
                      style: TextStyle(
                        fontWeight: currentTabIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Complaints",
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
                    Center(
                      child: StreamBuilder<List<Post>>(
                        stream: _postsService.getAllPostsOf(widget.userProfile),
                        builder: (context, postsSnapshot) {
                          if (postsSnapshot.hasError) {
                            print("error: " + postsSnapshot.error.toString());
                            return Text(
                              "Something went wrong while fetching Posts, please try again later!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          if (!postsSnapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          List<Post> posts = postsSnapshot.data;
                          if (posts.isEmpty) return Text("No posts found!");
                          return GridView.count(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: posts
                                .map((post) => PostGridItem(post))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: StreamBuilder<List<Post>>(
                        stream: _complaintsService
                            .getAllComplaintsOf(widget.userProfile),
                        builder: (context, complaintsSnapshot) {
                          if (complaintsSnapshot.hasError) {
                            print("error: " + complaintsSnapshot.error.toString());
                            return Text(
                              "Something went wrong while fetching complaints, please try again later!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          if (!complaintsSnapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          List<Post> complaints = complaintsSnapshot.data;

                          if (complaints.isEmpty)
                            return Text("No complaints found!");
                          return GridView.count(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: complaints
                                .map((complaint) => PostGridItem(complaint))
                                .toList(),
                          );
                        },
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
        backgroundImage: widget?.userProfile?.avatarUrl != null
            ? NetworkImage(widget.userProfile.avatarUrl)
            : AssetImage("assets/images/avatar_demo.jpeg"),
        // child: Image.asset(),
        radius: 60,
      ),
    );
  }
}

class PostGridItem extends StatelessWidget {
  final Post post;

  const PostGridItem(this.post);

  @override
  Widget build(BuildContext context) {
    return post.imageUrl != null
        ? GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.feedSingleScreen,
                  arguments: FeedSingleScreenArguments(
                    post: post,
                  ));
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(post.imageUrl, fit: BoxFit.cover),
            ),
          )
        : Container();
  }
}

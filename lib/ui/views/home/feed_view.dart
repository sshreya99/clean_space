import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/complaints_service.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/widgets/feed_item.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final PostsService _postsService =
  locator<PostsService>();
  final ComplaintsService _complaintsService =
  locator<ComplaintsService>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: UnFocusWrapper(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(
              color: ThemeColors.primary
            ),

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
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.startupScreen,
                                (route) => route == null
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
            bottom: TabBar(
              indicatorColor: ThemeColors.primary,
              tabs: [
                Tab(
                  child: Text("Posts", style: TextStyle(
                    color: ThemeColors.primary,
                  ),),

                ),Tab(
                  child: Text("Complaints", style: TextStyle(
                    color: ThemeColors.primary,
                  ),),
                ),
              ],
            ),
            title: Text("Clean Space", style: TextStyle(
              color: ThemeColors.primary,
            ),),
          ),
          body: TabBarView(
            children: [
              Center(
                child: StreamBuilder(
                  stream: _postsService.getAllPosts(),
                  builder: (context, complaintsSnapshot) {
                    if (complaintsSnapshot.hasError) {
                      print("error: " +  complaintsSnapshot.error);
                      return Text(
                        "Something went wrong while fetching complaints, please try again later!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    if (!complaintsSnapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    List<Post> posts = complaintsSnapshot.data;

                    if(posts.isEmpty)
                      return Text("No complaints found!");
                    return ListView(
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 20,
                      //   vertical: 20,
                      // ),

                      children: posts
                          .map((post) => FeedItem(post: post))
                          .toList(),
                    );
                  },
                ),
              ),
              Center(
                child: StreamBuilder(
                  stream: _complaintsService.getAllComplaints(),
                  builder: (context, complaintsSnapshot) {
                    if (complaintsSnapshot.hasError) {
                      print("error: " +  complaintsSnapshot.error);
                      return Text(
                        "Something went wrong while fetching complaints, please try again later!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    if (!complaintsSnapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    List<Post> posts = complaintsSnapshot.data;

                    if(posts.isEmpty)
                      return Text("No complaints found!");
                    return ListView(
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 20,
                      //   vertical: 20,
                      // ),

                      children: posts
                          .map((post) => FeedItem(post: post))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

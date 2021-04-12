import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/widgets/feed_item.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';

class AreaFeedView extends StatefulWidget {
  final Location location;

  const AreaFeedView({this.location});

  @override
  _AreaFeedViewState createState() => _AreaFeedViewState();
}

class _AreaFeedViewState extends State<AreaFeedView> {
  final PostsService _postsService = locator<PostsService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: UnFocusWrapper(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.location.area,
            style: TextStyle(color: ThemeColors.primary),
          ),
          backgroundColor: Colors.white,
          leading: BackButton(color: ThemeColors.primary,),
          actionsIconTheme: IconThemeData(color: ThemeColors.primary),
          bottom: TabBar(
            indicatorColor: ThemeColors.primary,
            tabs: [
              Tab(
                child: Text(
                  "Posts",
                  style: TextStyle(
                    color: ThemeColors.primary,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Complaints",
                  style: TextStyle(
                    color: ThemeColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: StreamBuilder(
                stream: _postsService.getPostsByArea(widget.location),
                builder: (context, postSnapshot) {
                  if (postSnapshot.hasError) {
                    print("error: " + postSnapshot.error.toString());
                    return Text(
                      "Something went wrong while fetching complaints, please try again later!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  if (!postSnapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  List<Post> posts = postSnapshot.data;

                  if (posts.isEmpty) return Text("No posts found!");
                  return ListView(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 20,
                    //   vertical: 20,
                    // ),

                    children:
                        posts.map((post) => FeedItem(post: post)).toList(),
                  );
                },
              ),
            ),
            Center(
              child: StreamBuilder(
                stream: _postsService.getPostsByArea(widget.location, isComplaint: true),
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
                  List<Post> posts = complaintsSnapshot.data;

                  if (posts.isEmpty) return Text("No posts found!");
                  return ListView(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 20,
                    //   vertical: 20,
                    // ),

                    children:
                        posts.map((post) => FeedItem(post: post)).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

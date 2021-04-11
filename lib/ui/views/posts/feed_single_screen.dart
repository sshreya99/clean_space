import 'package:clean_space/models/post.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/widgets/feed_item.dart';
import 'package:flutter/material.dart';

class FeedSingleScreen extends StatelessWidget {
  final Post post;

  const FeedSingleScreen({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          post.isComplaint ? "Complaint" : "Post",
          style: TextStyle(color: ThemeColors.primary),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FeedItem(
            post: post,
            isSinglePost: true,
          ),
          SizedBox(height: 30),
          Material(
            elevation: 3,
            shape: CircleBorder(),
            child: CircleAvatar(radius: 25,

              backgroundColor: Colors.white,
              child: CloseButton(color: ThemeColors.primary,),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:clean_space/ui/utils/constants.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedItem extends StatefulWidget {
  final Post post;
  final bool isSinglePost;

  FeedItem({this.post, this.isSinglePost = false});

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  final UserProfileService _userProfileService = locator<UserProfileService>();
  final PostsService _postsService = locator<PostsService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 10.0,
            offset: Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<UserProfile>(
            future: _userProfileService.getUserProfile(widget.post.author),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container(
                  height: 72,
                  width: double.infinity,
                );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profileScreen,
                        arguments:
                            ProfileScreenArguments(userProfile: snapshot.data));
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: snapshot?.data?.avatarUrl != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(snapshot.data.avatarUrl),
                        )
                      : CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                  title: snapshot?.data?.username != null
                      ? Text(
                          snapshot.data.username,
                          style: TextStyle(color: Colors.black),
                        )
                      : Container(),
                  subtitle: Text(widget.post.location.area),
                  trailing: _authenticationService.currentFirebaseUser.uid ==
                          snapshot.data.uid
                      ? PopupMenuButton<String>(
                          onSelected: choiceAction,
                          itemBuilder: (context) {
                            return Constants.choices
                                .map(
                                  (choice) => PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  ),
                                )
                                .toList();
                          },
                        )
                      : null,
                ),
              );
            },
          ),
          Center(
            child: Container(
              height: 200,
              width: double.infinity,
              child: widget.post.imageUrl == null
                  ? Center(
                      child: Icon(Icons.image_not_supported),
                    )
                  : Image.network(
                      widget.post.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up),
                        SizedBox(width: 10),
                        Text("125k"),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Icon(Icons.comment),
                            SizedBox(width: 10),
                            Text("126k"),
                          ],
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(DateFormat("MMM, d").format(widget.post.createdAt)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.post.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "See all 220 comments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          if (!widget.isSinglePost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextFormField(
                borderColor: Colors.black12,
                hintText: "Type your comment...",
                borderRadius: BorderRadius.circular(50),
              ),
            ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    print(widget.post);
    if (choice == Constants.choices[0]) {
      Navigator.pushNamed(
        context,
        Routes.createPostScreen,
        arguments: CreatePostScreenArguments(
          isComplaint: widget.post?.isComplaint,
          post: widget.post,
        ),
      );
    } else if (choice == Constants.choices[1]) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
              "Are you sure you want to delete this post? this action can not be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _postsService.deletePost(widget.post.id);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }
  }
}

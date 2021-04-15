import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:clean_space/ui/utils/constants.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/ui_helpers.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:image_downloader/image_downloader.dart';

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

  UserProfile _postUserProfile;

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
              // setState(() {
              _postUserProfile = snapshot.data;
              // });
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
          PostFooter(
            post: widget.post,
            postUserProfile: _postUserProfile,
          )
        ],
      ),
    );
  }

  void choiceAction(String choice) {
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

class PostLikeWidget extends StatefulWidget {
  final Post post;

  PostLikeWidget(this.post);

  @override
  _PostLikeWidgetState createState() => _PostLikeWidgetState();
}

class _PostLikeWidgetState extends State<PostLikeWidget> {
  UserProfile currentUserProfile;
  final PostsService _postsService = locator<PostsService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  void initState() {
    fetchCurrentUserProfile();
    super.initState();
  }

  void fetchCurrentUserProfile() async {
    currentUserProfile = await _authenticationService.currentUserProfile;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostLike>>(
      stream: _postsService.getLikesOf(widget.post),
      builder: (context, snapshot) {
        bool hasCurrentUserLiked = snapshot?.data
                ?.map((pl) => pl.id)
                ?.contains(_authenticationService.currentFirebaseUser.uid) ??
            false;

        int likesCount = snapshot?.data?.length ?? 0;
        return Row(
          children: [
            IconButton(
              icon: hasCurrentUserLiked
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_border),
              onPressed: () async {
                if (currentUserProfile == null) return;
                if (hasCurrentUserLiked) {
                  return await _postsService.removeLike(
                      widget.post, currentUserProfile);
                }
                await _postsService.addLike(widget.post, currentUserProfile);
              },
            ),
            // SizedBox(width: 5),
            GestureDetector(
              onTap: likesCount <= 0 ? null :  () {
                Navigator.pushNamed(context, Routes.postLikesPage,
                    arguments: PostLikesPageArguments(posLikes: snapshot.data));
              },
              child: Text("$likesCount ${likesCount == 1 ? "Like" : "Likes"}"),
            ),
          ],
        );
      },
    );
  }
}

class PostFooter extends StatefulWidget {
  final Post post;
  final UserProfile postUserProfile;

  const PostFooter({this.post, this.postUserProfile});

  @override
  _PostFooterState createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  bool isImageDownloadingForShare = false;
  String downloadedImageId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PostLikeWidget(widget.post),
                  // SizedBox(width: 20),
                  // Row(
                  //   children: [
                  //     Icon(Icons.comment),
                  //     SizedBox(width: 10),
                  //     Text("126k"),
                  //   ],
                  // ),
                  SizedBox(width: 20),
                  isImageDownloadingForShare
                      ? CircularProgressIndicator()
                      : IconButton(
                          onPressed: () async {
                            setState(() {
                              isImageDownloadingForShare = true;
                            });
                            if (downloadedImageId == null) {
                              downloadedImageId =
                                  await ImageDownloader.downloadImage(
                                      widget.post.imageUrl);
                            }

                            if (downloadedImageId == null)
                              return showErrorDialog(context,
                                  errorMessage: "Unable to download image!");
                            String imagePath = await ImageDownloader.findPath(
                                downloadedImageId);
                            setState(() {
                              isImageDownloadingForShare = false;
                            });
                            Share.shareFiles([imagePath],
                                text:
                                    "See this ${widget.post.isComplaint ? "complaint" : "post"} shared by ${widget.postUserProfile.username}. \n '${widget.post.content.trim()}' \n\nfrom *clean space*");
                          },
                          icon: Icon(Icons.share),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 5),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: Text(
        //     "See all 220 comments",
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
        // SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: CustomTextFormField(
        //     borderColor: Colors.black12,
        //     hintText: "Type your comment...",
        //     borderRadius: BorderRadius.circular(50),
        //   ),
        // ),
      ],
    );
  }
}

class PostLikesPage extends StatefulWidget {
  final List<PostLike> posLikes;

  const PostLikesPage(this.posLikes);

  @override
  _PostLikesPageState createState() => _PostLikesPageState();
}

class _PostLikesPageState extends State<PostLikesPage> {
  UserProfileService _userProfileService = locator<UserProfileService>();
  bool isFetchingProfile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
      ),
      body: ListView(
        children: widget.posLikes
            .map(
              (postLike) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: postLike.avatarUrl == null
                      ? null
                      : NetworkImage(postLike.avatarUrl),
                  backgroundColor: ThemeColors.primary,
                  child: postLike.avatarUrl == null ? Icon(Icons.person) : null,
                ),
                title: Text(postLike.username),
                subtitle: Text(postLike.email),
                trailing: isFetchingProfile ? CircularProgressIndicator() : Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () async {
                  setState(() {
                    isFetchingProfile = true;
                  });
                  final _userProfile =
                      await _userProfileService.getUserProfile(postLike.id);

                  setState(() {
                    isFetchingProfile = false;
                  });
                  if (_userProfile == null) {
                    showErrorDialog(context,
                        errorMessage:
                            "Something went wrong, please try again later!");
                  }
                  Navigator.pushNamed(context, Routes.profileScreen,
                      arguments:
                          ProfileScreenArguments(userProfile: _userProfile));
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

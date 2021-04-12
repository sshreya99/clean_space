import 'dart:io';
import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/image_services.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/validators/auth_validators.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/utils/helper.dart';

class EditProfileView extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileView({this.userProfile});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _editProfileFormKey = GlobalKey<FormState>();
  final _usernameTextEditingController = TextEditingController();
  final _bioTextEditingController = TextEditingController();
  final _phoneNumberTextEditingController = TextEditingController();

  final _complaintsService = locator<PostsService>();
  final _userProfileService = locator<UserProfileService>();
  bool isPasswordVisible = false;
  bool isLoading = false;
  File _image;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.userProfile != null) {
      _usernameTextEditingController.text = widget.userProfile.username;
      _bioTextEditingController.text = widget.userProfile.bio;
      _phoneNumberTextEditingController.text = widget.userProfile.phone;
    } else {
      _usernameTextEditingController.text = "widget.userProfile.username";
      _bioTextEditingController.text = "widget.userProfile.bio";
      _phoneNumberTextEditingController.text = "widget.userProfile.phone";
    }
  }

  // getCurrentUser() async {
  //   _userProfile = await _authenticationService.currentUserProfile;
  // }

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
                      onTap: () async {
                        File image = await ImageService.openCameraForImage();
                        setState(() {
                          _image = image;
                        });
                      },
                      child: Text(
                        "From Camera",
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
                      onTap: () async {
                        File image = await ImageService.openGalleryForImage();
                        setState(() {
                          _image = image;
                        });
                      },
                      child: Text(
                        "From Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
    setState(() {
    });
  }

  updateProfile() async {
    imageUrl = await _complaintsService.uploadImageAndGetDownloadableUrl(
        _image, genImageName(_image, currentUser: widget.userProfile));
    widget.userProfile.avatarUrl = imageUrl;
    widget.userProfile.username = _usernameTextEditingController.text;
    widget.userProfile.bio = _bioTextEditingController.text;
    widget.userProfile.phone = _phoneNumberTextEditingController.text;

    setState(() {
      isLoading = true;
    });

    await _userProfileService.updateAvatarImageInUserProfile(
        widget.userProfile.uid, imageUrl);
    await _userProfileService.updateUserProfile(widget.userProfile);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildProfileAvatar() {
      return Padding(
        padding: const EdgeInsets.only(top: 70),
        child: CircleAvatar(
          backgroundImage: _image != null
              ? FileImage(_image)
              : widget.userProfile?.avatarUrl != null
                  ? NetworkImage(widget.userProfile.avatarUrl)
                  : AssetImage("assets/images/avatar_demo.jpeg"),

          // child: Image.asset(),
          radius: 60,
        ),
      );
    }

    return UnFocusWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildProfileAvatar(),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet();
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: ThemeColors.primary, width: 1),
                            ),
                            child: Icon(
                              Icons.camera_enhance,
                              color: ThemeColors.primary,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 50),
                Form(
                  key: _editProfileFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _usernameTextEditingController,
                        hintText: "Username",
                        validator: (value) =>
                            AuthValidators.validateEmpty(value, "Username"),
                      ),
                      CustomTextFormField(
                        controller: _bioTextEditingController,
                        validator: AuthValidators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Bio",
                      ),
                      CustomTextFormField(
                        controller: _phoneNumberTextEditingController,
                        hintText: "Phone Number",
                        validator: AuthValidators.validatePhone,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                isLoading ? CircularProgressIndicator() : CustomRoundedRectangularButton(
                  color: ThemeColors.primary,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: updateProfile,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

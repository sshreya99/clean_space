import 'dart:io';
import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/ui/utils/constants.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/utils/ui_helpers.dart';
import 'package:clean_space/ui/views/auth/widgets/custom_text_form_field.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:clean_space/ui/views/widgets/unfocus_wrapper.dart';
import 'package:clean_space/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/services/image_services.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:stacked/stacked.dart';

class CreatePostScreen extends StatefulWidget {
  final bool isComplaint;
  final Post post;

  const CreatePostScreen({this.isComplaint = false, this.post});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  PostsService _postService = locator<PostsService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  TextEditingController _commentAboutPlace = TextEditingController();

  UserProfile _userProfile;
  File _image;
  String _selectedCatValue = "Select Category";
  String _selectedAreaValue = "";
  final _newCategoryTextEditor = TextEditingController();
  bool isLoading = false;
  bool isCatVisible = true;
  List<DropdownMenuItem> categoryItems;

  List<DropdownMenuItem> areaItems = Constants.areas
      .map(
        (area) => DropdownMenuItem<String>(
          child: Text(area),
          value: area,
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    getUserProfile();

    List<String> category = widget.isComplaint
        ? Constants.complaintCategory
        : Constants.postCategory;
    categoryItems = category
        .map(
          (category) => DropdownMenuItem<String>(
            child: Text(category),
            value: category,
          ),
        )
        .toList();

    if (widget.post != null) {
      _selectedCatValue = widget.post.category;
      _selectedAreaValue = widget.post.location.area;
      _commentAboutPlace.text = widget.post.content;
    }
  }

  getUserProfile() async {
    _userProfile = await _authenticationService.currentUserProfile;
  }

  void createPost() async {

    if(_image == null){
      return showErrorDialog(context, errorMessage: "Image is required!");
    }else if (_selectedCatValue == "Select Category"){
      return showErrorDialog(context, errorMessage: "Please select category!");
    } else if(_selectedAreaValue == null || _selectedAreaValue.isEmpty){
      return showErrorDialog(context, errorMessage: "Please select area!");
    }
    setState(() {
      isLoading = true;
    });

    String imageUrl = await _postService.uploadImageAndGetDownloadableUrl(
        _image, genImageName(_image, currentUser: _userProfile));
    print(imageUrl);
    Post post = Post(
      id: _authenticationService.currentFirebaseUser.uid,
      imageUrl: imageUrl,
      category: _selectedCatValue,
      content: _commentAboutPlace.value.text.trim(),
      location: Location(
          country: "india",
          state: 'gujarat',
          city: 'vadodara',
          area: _selectedAreaValue),
      author: _userProfile.uid,
      createdAt: DateTime.now(),
      isComplaint: widget.isComplaint,
    );

    await _postService.createPost(post);

    setState(() {
      isLoading = false;
      _selectedCatValue = "";
      _newCategoryTextEditor.clear();
      _selectedAreaValue = "";
      _commentAboutPlace.clear();
      _image = null;
    });

    Navigator.pop(context);
  }

  void addCategory() async {
    await _postService.addPostCategory(PostCategory(
        category: _newCategoryTextEditor.text,
        isForComplaint: widget.isComplaint));
    setState(() {
      _selectedCatValue = _newCategoryTextEditor.text;
    });
    isCatVisible = true;
  }

  void editPost() async {
    widget.post.content = _commentAboutPlace.text;
    widget.post.category = _selectedCatValue;
    widget.post.location.area = _selectedAreaValue;
    widget.post.updatedAt = DateTime.now();

    setState(() {
      isLoading = true;
    });
    await _postService.updatePost(widget.post);

    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            },
          ),
          title: Text(
            widget.isComplaint ? "Add Complaint" : "Add Post",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: widget.post == null ? createPost : editPost,
                        child: Text(
                          widget.post == null ? "Post" : "Edit",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                      ),
              ),
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<List<PostCategory>>(
            stream: widget.isComplaint
                ? _postService.getPostCategory(isForComplaint: true)
                : _postService.getPostCategory(isForComplaint: false),
            builder: (context, snapshot) {
              // List<PostCategory> _postCatList = snapshot.data;
              // List<DropdownMenuItem> _catItems = _postCatList
              //     .map((cat) => DropdownMenuItem(
              //           child: Text(cat.category),
              //           value: cat.category,
              //         ))
              //     .toList();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 300,
                          child: _image != null
                              ? Image.file(_image)
                              : widget.post?.imageUrl != null
                                  ? Image.network(widget.post.imageUrl)
                                  : Icon(Icons.image),
                        ),
                      ),
                    ),
                    if (widget.post == null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                File image =
                                    await ImageService.openCameraForImage();
                                setState(() {
                                  _image = image;
                                });
                              },
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.green,
                                        Colors.blue,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(5, 5),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Open Camera',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                File image =
                                    await ImageService.openGalleryForImage();
                                setState(() {
                                  _image = image;
                                });
                              },
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.green,
                                        Colors.blue,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(5, 5),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Open Gallery',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomRoundedRectangularButton(
                          height: 60,
                          onPressed:  () async {
                            String selectedCategory = await showSearch<String>(
                                context: context,
                                delegate: SearchCategoryDelegate(isForComplaint: widget.isComplaint));
                            if(selectedCategory != null){
                              setState(() {
                                _selectedCatValue = selectedCategory;
                              });
                            }
                          },
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.apps, size: 20, color: Colors.grey),
                              SizedBox(width: 10),
                              Text(_selectedCatValue, style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),

                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(5),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromRGBO(0, 0, 0, 0.06),
                    //         blurRadius: 10.0,
                    //         offset: Offset(2, 3),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Visibility(
                    //     visible: isCatVisible,
                    //     child: Row(
                    //       children: [
                    //         Icon(Icons.apps, size: 20, color: Colors.grey),
                    //
                    //         // Expanded(
                    //         //   child: SearchableDropdown.single(
                    //         //     underline: Container(),
                    //         //     displayClearIcon: false,
                    //         //     items: _catItems,
                    //         //     value: _selectedCatValue,
                    //         //     hint: "Select Category",
                    //         //     searchHint: "Select one",
                    //         //     onChanged: (value) {
                    //         //       print(value);
                    //         //       setState(() {
                    //         //         _selectedCatValue = value;
                    //         //         if (_selectedCatValue == "Add Category") {
                    //         //           isCatVisible = false;
                    //         //         }
                    //         //       });
                    //         //     },
                    //         //     isExpanded: true,
                    //         //   ),
                    //         // ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // _selectedCatValue == "Add Category"
                    //     ? Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 20),
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 5),
                    //         child: Visibility(
                    //             visible: true,
                    //             child: CustomTextFormField(
                    //               controller: _newCategoryTextEditor,
                    //               hintText: "Add Category",
                    //             )),
                    //       )
                    //     : Visibility(
                    //         child: Container(),
                    //         visible: false,
                    //       ),
                    // _selectedCatValue == "Add Category"
                    //     ? Visibility(
                    //         visible: true,
                    //         child: Container(
                    //           margin: EdgeInsets.only(left: 20),
                    //           child: CustomRoundedRectangularButton(
                    //             width: 100,
                    //             onPressed: addCategory,
                    //             color: ThemeColors.primary,
                    //             child: Text(
                    //               "Add",
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : Visibility(
                    //         child: Container(),
                    //         visible: false,
                    //       ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical:0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            blurRadius: 10.0,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.apps, size: 20, color: Colors.grey),
                          Expanded(
                            child: SearchableDropdown.single(
                              underline: Container(),
                              displayClearIcon: false,
                              items: areaItems,
                              value: _selectedAreaValue,
                              hint: DropdownMenuItem(
                                child:Text("Add Place"),
                              ),

                              searchHint: "Select one",
                              onChanged: (value) {
                                setState(() {
                                  _selectedAreaValue = value;
                                });

                              },

                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField(
                        controller: _commentAboutPlace,
                        hintText: "Write something about this place...",
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class SearchCategoryDelegate extends SearchDelegate<String> {
  final bool isForComplaint;
  SearchCategoryDelegate({this.isForComplaint = false});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return ViewModelBuilder<SearchCategoryViewModel2>.reactive(
        viewModelBuilder: () => SearchCategoryViewModel2(isForComplaint),
        // onModelReady: (model) => model.initialize(isForComplaint),
        builder: (context, model, snapshot) {
          if (!model.dataReady) return CircularProgressIndicator();

          final List<PostCategory> result = model.data
              .where((category) =>
                  category.category.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView(
            children: [
              ...result
                  .map(
                    (category) => ListTile(
                      title: Text(category.category),
                      onTap: () => close(context, category.category),
                    ),
                  )
                  .toList(),
              Divider(),
              ListTile(
                title: !model.showAddNewCategoryTextField
                    ? Text(
                        "Add New Category",
                        style: TextStyle(color: ThemeColors.primary),
                      )
                    : Form(
                        key: model.addNewCategoryFormKey,
                        child: TextFormField(
                          controller: model.addNewCategoryTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Add New Category",
                            suffix: GestureDetector(
                              onTap: () {
                                model.setShowAddNewCategoryTextField(false);
                              },
                              child: Icon(Icons.close, size: 20,),
                            ),
                          ),
                          validator: (String value) {
                            if (value.length < 4) {
                              return "Category name should be at least of 4 character!";
                            }
                            return null;
                          },
                        ),
                      ),
                onTap: !model.showAddNewCategoryTextField
                    ? () => model.setShowAddNewCategoryTextField(true, query)
                    : null,
                trailing: !model.showAddNewCategoryTextField
                    ? null
                    : model.isBusy
                        ? CircularProgressIndicator()
                        : IconButton(
                            icon: Icon(Icons.add,
                            color: ThemeColors.primary,
                            ),
                            onPressed: model.addNewCategory,
                          ),
              ),
            ],
          );
        });
  }
}

class SearchCategoryViewModel2 extends StreamViewModel<List<PostCategory>> {
  PostsService _postService = locator<PostsService>();
  bool _showAddNewCategoryTextField = false;
  final bool isForComplaint;

  SearchCategoryViewModel2(this.isForComplaint);
  //
  // void initialize(bool isForComplaint){
  //   // isForComplaint = isForComplaint;
  // }

  final GlobalKey<FormState> addNewCategoryFormKey = GlobalKey<FormState>();
  final TextEditingController addNewCategoryTextEditingController =
      TextEditingController();

  bool get showAddNewCategoryTextField => _showAddNewCategoryTextField;

  setShowAddNewCategoryTextField(bool value, [String query = ""]) {
    _showAddNewCategoryTextField = value;
    addNewCategoryTextEditingController.text = query;
    notifyListeners();
  }

  void addNewCategory() async {
    if (!addNewCategoryFormKey.currentState.validate()) return;
    setBusy(true);
    await _postService.addPostCategory(
      PostCategory(
        category: addNewCategoryTextEditingController.text,
        isForComplaint: isForComplaint,
      ),
    );
    addNewCategoryTextEditingController.clear();
    _showAddNewCategoryTextField = false;
    setBusy(false);
  }

  @override
  Stream<List<PostCategory>> get stream => _postService.getPostCategory(isForComplaint: isForComplaint);
}

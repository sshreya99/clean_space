import 'package:clean_space/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/services/image_services.dart';
import 'package:clean_space/app/router.gr.dart';

class ComplaintsView extends StatefulWidget {
  @override
  _ComplaintsViewState createState() => _ComplaintsViewState();
}

class _ComplaintsViewState extends State<ComplaintsView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Add Complaint",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Post",
                style: TextStyle(color: Colors.lightBlue, fontSize: 20),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 200,
                  width: 300,
                  child: Placeholder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await ImageService.openCameraForImage();
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  GestureDetector(
                    onTap: () async {
                      await ImageService.openGalleryForImage();
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ExpansionTile(
              title: Row(
                children: [
                  Icon(Icons.apps),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Select Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: Constants.complaintCategory
                  .map((String choice) => Text(choice))
                  .toList(),
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Add Place",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Work",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
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
                color: index == _currentIndex ? Colors.black : Colors.grey[700],
              )
            : Container(),
      ),
    );
  }

  void postComplaint() {}
}

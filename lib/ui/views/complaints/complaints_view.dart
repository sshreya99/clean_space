import 'package:flutter/material.dart';
import 'package:clean_space/services/image_services.dart';

import 'package:clean_space/app/locator.dart';

class ComplaintsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.keyboard_arrow_left, color: Colors.black,),
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
                children: [
                  GestureDetector(
                    onTap: () async {
                      await ImageService.openCameraForImage();
                    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.blue,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius
                            : BorderRadius.circular(20),
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
                            Icon(Icons.camera_alt, color: Colors.white,),
                            Text(
                              'Open Camera',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  GestureDetector(
                    onTap: () async {
                      await ImageService.openGalleryForImage();
                    },
                    child: Container(
                      width: 180,
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
                              Icon(Icons.image, color: Colors.white,),
                              Text(
                                'Open Gallery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
                  SizedBox(width: 20,),
                  Text("Select Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
              children: [
                Align(alignment: Alignment.centerLeft,child: Text("Category 1", style: TextStyle(fontSize: 18,),)),
                Align(alignment: Alignment.centerLeft, child: Text("Category 2", style: TextStyle(fontSize: 18,),)),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 20,),
                  Text("Add Place", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
              children: [
                Align(alignment: Alignment.centerLeft,child: Text("Home", style: TextStyle(fontSize: 18,),)),
                Align(alignment: Alignment.centerLeft, child: Text("Work", style: TextStyle(fontSize: 18,),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:clean_space/ui/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20,
              ),
              title: Text("Rohan_Sharma_11"),
              subtitle: Text("Manjalpur"),
              trailing: PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (context){
                  return Constants.choices.map((String choice) => PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  )).toList();
                },

              )
            ),
            Center(
                child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Placeholder())),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thumb_up),
                          SizedBox(width: 10,),
                          Text("125k"),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              Icon(Icons.comment),
                              SizedBox(width: 10,),
                              Text("126k"),
                            ],
                          ),
                          SizedBox(width: 20,),
                          IconButton(
                            icon: Icon(Icons.share),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("Apr 24"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Text("Lorem Ipsum \nLorem Ipsum"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Text(
                "See all 220 comments",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice){
    print(choice);
  }
}

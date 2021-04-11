import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                ),
                title: Text("Rohan_Sharma_11"),
                subtitle: Text("Manjalpur"),
                trailing: IconButton(
                  icon: Icon(Icons.menu_rounded),
                  onPressed: (){},
                ),
              ),
              Container(height: 100, width: 200, child: Placeholder()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.thumb_up),
                      Text("125k"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment),
                      Text("126k"),
                    ],
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.share),
                  ),
                  Text("Apr 24"),
                ],
              ),
            ],
          ),
          Text("Lorem Ipsum \nLorem Ipsum"),
          Text("See all 220 comments", style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

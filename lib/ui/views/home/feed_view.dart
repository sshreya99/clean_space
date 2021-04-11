import 'package:clean_space/ui/views/widgets/feed_item.dart';
import 'package:flutter/material.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
        FeedItem(),
        FeedItem(),
        FeedItem(),
        FeedItem(),
        FeedItem(),
        FeedItem(),
      ]
      ),
    );
  }
}

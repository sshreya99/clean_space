import 'package:flutter/material.dart';

class RankWidget extends CustomClipper<Path> {
  double offset;

  RankWidget(this.offset);
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(offset,height);
    path.lineTo(width - offset, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}

import 'package:flutter/material.dart';

class CustomRoundedRectangularButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final double width;
  final double height;
  final Widget child;

  const CustomRoundedRectangularButton({Key key, this.onPressed, this.color, this.width, this.height, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? Color(0xff6C63FF),
      minWidth: width ?? double.infinity,
      height: height?? 50,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

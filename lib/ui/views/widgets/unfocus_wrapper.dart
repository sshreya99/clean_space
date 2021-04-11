import 'package:flutter/material.dart';

class UnFocusWrapper extends StatelessWidget {
  final Widget child;

  const UnFocusWrapper({this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

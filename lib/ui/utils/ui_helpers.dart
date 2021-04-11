import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, {@required String errorMessage}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Error Occurred!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: ThemeColors.primary),
          ),
        ),
      ],
    ),
  );
}

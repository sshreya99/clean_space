import 'package:clean_space/app/locator.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/utils/constants/assets/image_assets.dart';
import 'package:clean_space/utils/enums/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.error: (context, sheetRequest, completer) =>
        _ErrorDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _ErrorDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _ErrorDialog({Key key, this.request, this.completer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        request.title,
        style: TextStyle(color: Colors.red),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ImageAssets.dialogImages + "/error.png",
            width: 120,
          ),
          SizedBox(height: 10),
          Text(request.description),
        ],
      ),
      actions: [
        TextButton(
          // color: Colors.deepPurpleAccent,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: ThemeColors.primary),
          ),
        ),
      ],
    );
  }
}

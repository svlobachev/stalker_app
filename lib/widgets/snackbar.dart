import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      MaterialColor currentColor, labelUndoText) {
    final SnackBar snackBar = SnackBar(
        action: SnackBarAction(
          label: 'Undo',
          // textColor: Colors.white,
          onPressed: () {
            // Some code to undo the change.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        backgroundColor: currentColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

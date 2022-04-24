import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSnackBar {
  CustomSnackBar(
      BuildContext context, Widget content, MaterialColor currentColor) {
    final SnackBar snackBar = SnackBar(
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.labelUndoText,
          textColor: Colors.yellowAccent,
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

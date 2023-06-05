import 'package:flutter/material.dart';
import 'package:notenow/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to Delete this note ?',
    optionsBuilder: () => {
      'Cancel' : false,
      'Delete' : true,
    },
  ).then((value) => value ?? false,
  );
}

import 'package:flutter/material.dart';

void showErrorDialog(String errorText, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Oops! An error occured'),
      content: Text(
        errorText,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(
            'Okay',
          ),
        )
      ],
    ),
  );
}

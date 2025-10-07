// lib/widgets/common/custom_modal.dart
import 'package:flutter/material.dart';

Future<void> showCustomModal({
  required BuildContext context,
  required String title,
  required Widget content,
  List<Widget>? actions,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
              splashRadius: 20,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: content,
        ),
        actions: actions,
      );
    },
  );
}
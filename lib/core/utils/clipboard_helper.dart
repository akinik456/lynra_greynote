import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> copyWithAutoClear(
  BuildContext context,
  String value,
  String snackText,
) async {
  if (value.isEmpty) return;

  await Clipboard.setData(ClipboardData(text: value));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(snackText)),
  );

  Future.delayed(const Duration(seconds: 15), () async {
    final current = await Clipboard.getData('text/plain');

    if (current?.text == value) {
      await Clipboard.setData(const ClipboardData(text: ''));
    }
  });
}

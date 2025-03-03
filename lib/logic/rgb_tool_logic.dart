import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RgbToolLogic {
  /// Business logic for the RGB colour tool

  /// Get the inverted colour for text based on the RGB values
  Color getInvertedColour(int r, int g, int b) {
    return r + g + b < 384 ? Colors.white : Colors.black;
  }

  /// Convert RGB values to a hexadecimal colour value
  String rgb2hex(int r, int g, int b) =>
      '#${r.toRadixString(16).padLeft(2, '0')}'
      '${g.toRadixString(16).padLeft(2, '0')}'
      '${b.toRadixString(16).padLeft(2, '0')}';

  /// Copy text to the clipboard and show a snackbar
  Future<void> copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
}

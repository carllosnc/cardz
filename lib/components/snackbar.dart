import 'package:flutter/material.dart';

extension SnackbarContext on BuildContext {
  void showSnackbar({
    required String message,
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        action: action,
        content: Text(message),
      ),
    );
  }
}

import 'package:flutter/material.dart';

extension AppColorsContext on BuildContext {
  Color get primaryColor => Colors.blue;
  Color get primary => Theme.of(this).colorScheme.primary;
}

extension AppAssetsContext on BuildContext {
  String get logo => "assets/images/logo.png";
}

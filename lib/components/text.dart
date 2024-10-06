import 'package:flutter/widgets.dart';

extension TextComponent on String {
  Text get pageTitle => Text(toUpperCase(),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ));

  Text get bigEmoji => Text(this,
      style: const TextStyle(
        fontSize: 100,
      ));
}

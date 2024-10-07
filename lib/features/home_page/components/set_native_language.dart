import 'package:flutter/material.dart';

class SetNativeLanguage extends StatefulWidget {
  const SetNativeLanguage({super.key});

  @override
  State<SetNativeLanguage> createState() => _SetNativeLanguageState();
}

class _SetNativeLanguageState extends State<SetNativeLanguage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.translate,
      ),
    );
  }
}

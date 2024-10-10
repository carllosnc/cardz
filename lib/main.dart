import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/app.dart';
import '/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load shared preferences
  await sharedPreferences.loadPreferences();

  //load database
  await database.init();

  localizeState.init(
    content: localizeLanguages,
  );

  runApp(const App());
}

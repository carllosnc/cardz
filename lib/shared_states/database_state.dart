import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/imports.dart';

class _Database extends ChangeNotifier {
  late Future<Database> _database;
  bool isLoading = false;

  List<FlashContent> flashContentList = [];

  int countOfEnglish = 0;
  int countOfPortuguese = 0;
  int countOfChinese = 0;
  int countOfJapanese = 0;
  int countOfItalian = 0;
  int countOfGerman = 0;
  int countOfFrench = 0;
  int countOfSpanish = 0;
  int countOfRussian = 0;

  Map<String, int> countByLanguage = {};

  init() async {
    _database = openDatabase(
      join(
        await getDatabasesPath(),
        'flashee.db',
      ),
      onCreate: (db, version) async {
        await db.execute(FlashContent.asSQL());
      },
      version: 1,
    );
  }

  Future<void> createFlashContent({
    required FlashContent flashContent,
    required Language language,
  }) async {
    isLoading = true;

    final db = await _database;

    var content = flashContent.toJson();

    content['synonyms'] = content['synonyms'].toString();
    content['examples'] = content['examples'].toString();

    await db.insert(
      'flashcontents',
      content,
    );

    getAllFlashContentByLanguage(language);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllFlashContentByLanguage(Language language) async {
    isLoading = true;

    final db = await _database;
    final result = await db.query(
      'flashcontents',
      where: 'languageToLearn = ?',
      whereArgs: [language.name],
    );

    flashContentList = result.map((item) {
      return FlashContent.fromJson(item);
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteFlashContent({
    required FlashContent flashContent,
    required Language language,
  }) async {
    isLoading = true;

    final db = await _database;

    await db.delete(
      'flashcontents',
      where: 'id = ?',
      whereArgs: [flashContent.id],
    );

    getAllFlashContentByLanguage(language);

    isLoading = false;
    notifyListeners();
  }
}

var database = _Database();

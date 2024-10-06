import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/imports.dart';

class _Database extends ChangeNotifier {
  late Future<Database> _database;
  bool isLoading = false;

  List<FlashContent> flashContentList = [];

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

  Future<void> createFlashContent(FlashContent flashContent) async {
    isLoading = true;

    final db = await _database;

    var content = flashContent.toJson();

    content['synonyms'] = content['synonyms'].toString();
    content['sentences'] = content['sentences'].toString();

    await db.insert(
      'flashcontents',
      content,
    );

    getAllFlashContent();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllFlashContent() async {
    isLoading = true;

    final db = await _database;
    final result = await db.query('flashcontents');

    flashContentList = result.map((item) {
      return FlashContent.fromJson(item);
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllFlashContentByLanguage(Language language) async {
    isLoading = true;

    final db = await _database;
    final result = await db.query('flashcontents', where: 'language = ?', whereArgs: [language.name]);

    flashContentList = result.map((item) {
      return FlashContent.fromJson(item);
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteFlashContent(FlashContent flashContent) async {
    isLoading = true;

    final db = await _database;

    await db.delete(
      'flashcontents',
      where: 'id = ?',
      whereArgs: [flashContent.id],
    );

    getAllFlashContent();

    isLoading = false;
    notifyListeners();
  }
}

var database = _Database();

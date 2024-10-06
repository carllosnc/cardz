// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'flash_content.g.dart';

@JsonSerializable(explicitToJson: true)
class FlashContent {
  int? id;
  final String? languageToLearn;
  final String word;
  final String emoji;
  final String category;
  final String translation;
  final String pronunciation;
  final String? descriptionGrammar;
  final String? descriptionUsage;
  final String? descriptionCultural;
  final dynamic synonyms;
  final dynamic sentences;

  FlashContent({
    this.id,
    required this.languageToLearn,
    required this.word,
    required this.emoji,
    required this.category,
    required this.translation,
    required this.descriptionGrammar,
    required this.descriptionUsage,
    required this.descriptionCultural,
    required this.pronunciation,
    required this.synonyms,
    required this.sentences,
  });

  static String asSQL() {
    return '''
      CREATE TABLE flashcontents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        languageToLearn TEXT NOT NULL,
        word TEXT NOT NULL,
        emoji TEXT NOT NULL,
        category TEXT NOT NULL,
        translation TEXT NOT NULL,
        descriptionGrammar TEXT NOT NULL,
        descriptionUsage TEXT NOT NULL,
        descriptionCultural TEXT NULL,
        pronunciation TEXT NOT NULL,
        synonyms TEXT NOT NULL,
        sentences TEXT NOT NULL
      );
    ''';
  }

  String adaptSynonyms() {
    return synonyms //
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(', ', '   •   ');
  }

  List<List<String>> adaptSentences() {
    return sentences //
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.split(' - ').toList())
        .toList();
  }

  bool hasDescriptionGrammar() {
    return descriptionGrammar != null && descriptionGrammar!.isNotEmpty;
  }

  bool hasDescriptionCultural() {
    return descriptionCultural != null && descriptionCultural!.isNotEmpty;
  }

  bool hasDescriptionUsage() {
    return descriptionUsage != null && descriptionUsage!.isNotEmpty;
  }

  factory FlashContent.fromJson(Map<String, dynamic> json) => _$FlashContentFromJson(json);
  Map<String, dynamic> toJson() => _$FlashContentToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashContent _$FlashContentFromJson(Map<String, dynamic> json) => FlashContent(
      id: (json['id'] as num?)?.toInt(),
      languageToLearn: json['languageToLearn'] as String?,
      word: json['word'] as String,
      emoji: json['emoji'] as String,
      category: json['category'] as String,
      translation: json['translation'] as String,
      descriptionGrammar: json['descriptionGrammar'] as String?,
      descriptionUsage: json['descriptionUsage'] as String?,
      descriptionCultural: json['descriptionCultural'] as String?,
      pronunciation: json['pronunciation'] as String,
      synonyms: json['synonyms'],
      examples: json['examples'],
    );

Map<String, dynamic> _$FlashContentToJson(FlashContent instance) => <String, dynamic>{
      'id': instance.id,
      'languageToLearn': instance.languageToLearn,
      'word': instance.word,
      'emoji': instance.emoji,
      'category': instance.category,
      'translation': instance.translation,
      'pronunciation': instance.pronunciation,
      'descriptionGrammar': instance.descriptionGrammar,
      'descriptionUsage': instance.descriptionUsage,
      'descriptionCultural': instance.descriptionCultural,
      'synonyms': instance.synonyms,
      'examples': instance.examples,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashError _$FlashErrorFromJson(Map<String, dynamic> json) => FlashError(
      hasError: json['hasError'] as bool,
      title: json['title'] as String,
      details: json['details'] as String,
      suggestion: json['suggestion'] as String,
    );

Map<String, dynamic> _$FlashErrorToJson(FlashError instance) =>
    <String, dynamic>{
      'hasError': instance.hasError,
      'title': instance.title,
      'details': instance.details,
      'suggestion': instance.suggestion,
    };

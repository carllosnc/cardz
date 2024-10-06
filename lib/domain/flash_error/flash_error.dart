import 'package:json_annotation/json_annotation.dart';

part 'flash_error.g.dart';

@JsonSerializable(explicitToJson: true)
class FlashError {
  final bool hasError;
  final String title;
  final String details;
  final String suggestion;

  FlashError({
    required this.hasError,
    required this.title,
    required this.details,
    required this.suggestion,
  });

  factory FlashError.fromJson(Map<String, dynamic> json) => _$FlashErrorFromJson(json);
  Map<String, dynamic> toJson() => _$FlashErrorToJson(this);
}

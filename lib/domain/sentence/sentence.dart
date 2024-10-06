import 'package:json_annotation/json_annotation.dart';

part 'sentence.g.dart';

@JsonSerializable(explicitToJson: true)
class Sentence {
  final String sentence;
  final String translation;

  Sentence({
    required this.sentence,
    required this.translation,
  });

  factory Sentence.fromJson(Map<String, dynamic> json) => _$SentenceFromJson(json);

  Map<String, dynamic> toJson() => _$SentenceToJson(this);
}

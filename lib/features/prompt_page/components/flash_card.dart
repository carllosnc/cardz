import 'package:flutter/material.dart';
import '/imports.dart';
import 'package:vw/vw.dart';
import './flash_card_details.dart';

class FlashCard extends StatefulWidget {
  final FlashContent flashContent;
  final Language languageToLearn;
  final Function onDelete;

  const FlashCard({
    super.key,
    required this.flashContent,
    required this.languageToLearn,
    required this.onDelete,
  });

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        openDetails(
          languageToLearn: widget.languageToLearn,
          context: context,
          flashContent: widget.flashContent,
          onDelete: widget.onDelete,
        );
      },
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      title: VWColumn(
        children: [
          widget.flashContent.category.text.fontSize(10).uppercase.bold,
          widget.flashContent.word.text.fontSize(24).firstUpper.bold,
        ],
      ),
      subtitle: widget //
          .flashContent
          .translation
          .text
          .fontSize(16)
          .firstUpper
          .color(context.primary),
      trailing: const Icon(
        Icons.chevron_right,
      ),
    );
  }
}

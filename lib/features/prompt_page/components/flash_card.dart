import 'package:flutter/material.dart';
import '/imports.dart';
import 'package:vw/vw.dart';

openDetails({
  required BuildContext context,
  required FlashContent flashContent,
  required Language languageToLearn,
}) {
  VWSheet.open(
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  title: const Text("Delete"),
                  content: const Text("Are you sure you want to delete this flashcard?"),
                  actions: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onErrorContainer.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () async {
                        await database.deleteFlashContent(
                          flashContent: flashContent,
                          language: languageToLearn,
                        );

                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Yes"),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onErrorContainer.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.delete_outline,
          ),
        ),
      ],
    ),
    context: context,
    body: SingleChildScrollView(
      child: SizedBox(
        child: VWColumn(
          gap: 10,
          children: [
            SizedBox(
              width: double.infinity,
              child: VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                horizontalAlignment: CrossAxisAlignment.center,
                gap: 4,
                children: [
                  flashContent.emoji.text.fontSize(60).center,
                  flashContent.category.text.fontSize(12).uppercase.bold.center,
                  flashContent.word.text.fontSize(26).bold.firstUpper.center,
                  flashContent.translation.text.fontSize(20).firstUpper.color(context.primary).center,
                ],
              ),
            ),
            const Divider(),
            VWRow(
              verticalAlignment: CrossAxisAlignment.center,
              gap: 10,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              children: [
                "Pronunciation :".text.fontSize(12).bold.uppercase,
                Text(
                  flashContent.pronunciation,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            if (flashContent.hasDescriptionGrammar()) const Divider(),
            if (flashContent.hasDescriptionGrammar())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "Grammar description:".text.fontSize(12).bold.uppercase,
                  flashContent.descriptionGrammar!.text.fontSize(16).firstUpper.color(context.primary),
                ],
              ),
            if (flashContent.hasDescriptionCultural()) const Divider(),
            if (flashContent.hasDescriptionCultural())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "Cultural description:".text.fontSize(12).bold.uppercase,
                  flashContent.descriptionCultural!.text.fontSize(16).firstUpper.color(context.primary),
                ],
              ),
            if (flashContent.hasDescriptionUsage()) const Divider(),
            if (flashContent.hasDescriptionUsage())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "Usage description:".text.fontSize(12).bold.uppercase,
                  flashContent.descriptionUsage!.text.fontSize(16).firstUpper.color(context.primary),
                ],
              ),
            if (flashContent.adaptSynonyms().isNotEmpty) const Divider(),
            if (flashContent.adaptSynonyms().isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: flashContent.adaptSynonyms().text.fontSize(16),
              ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                gap: 20,
                children: flashContent.adaptExamples().where((e) => e.length > 1).map((sentence) {
                  return VWColumn(
                    children: [
                      sentence[0].trim().text.fontSize(16).bold.firstUpper,
                      sentence[1].trim().text.fontSize(16).color(context.primary),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class FlashCard extends StatefulWidget {
  final FlashContent flashContent;
  final Language languageToLearn;

  const FlashCard({
    super.key,
    required this.flashContent,
    required this.languageToLearn,
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
        );
      },
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      title: VWColumn(
        children: [
          widget.flashContent.category.text.fontSize(10).uppercase.bold,
          widget.flashContent.word.text.fontSize(20).firstUpper.bold,
        ],
      ),
      subtitle: widget.flashContent.translation.text.fontSize(16).firstUpper.color(context.primary),
      trailing: const Icon(
        Icons.chevron_right,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/imports.dart';
import 'package:vw/vw.dart';
import 'package:localize/localize.dart';

openDetails({
  required BuildContext context,
  required FlashContent flashContent,
  required Language languageToLearn,
  required Function onDelete,
}) {
  VWSheet.open(
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    appBar: AppBar(
      title: flashContent.word.pageTitle,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  title: "delete".localize.text.bold,
                  content: "are you sure you want to delete this flashcard?".localize.text,
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

                        onDelete();

                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: "yes".localize.text.bold,
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
                      child: "no".localize.text.bold,
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
          gap: 30,
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
                  flashContent //
                      .translation
                      .text
                      .fontSize(20)
                      .firstUpper
                      .color(context.primary)
                      .center,
                ],
              ),
            ),
            const Divider(),
            VWColumn(
              gap: 10,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              children: [
                "pronunciation".localize.text.fontSize(13).bold.uppercase,
                if (flashContent.pronunciation != null)
                  Text(
                    flashContent.pronunciation ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                    ),
                  ),
              ],
            ),
            if (flashContent.hasDescriptionGrammar())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "grammar description".localize.text.fontSize(13).bold.uppercase,
                  flashContent //
                      .descriptionGrammar!
                      .text
                      .fontSize(16)
                      .firstUpper
                      .color(context.primary),
                ],
              ),
            if (flashContent.hasDescriptionCultural())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "cultural description".localize.text.fontSize(13).bold.uppercase,
                  flashContent //
                      .descriptionCultural!
                      .text
                      .fontSize(16)
                      .firstUpper
                      .color(context.primary),
                ],
              ),
            if (flashContent.hasDescriptionUsage())
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                gap: 5,
                children: [
                  "usage description".localize.text.fontSize(13).bold.uppercase,
                  flashContent //
                      .descriptionUsage!
                      .text
                      .fontSize(16)
                      .firstUpper
                      .color(context.primary),
                ],
              ),
            if (flashContent.adaptSynonyms().isNotEmpty)
              VWColumn(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                children: [
                  "synonyms".localize.text.fontSize(13).bold.uppercase,
                  flashContent.adaptSynonyms().text.fontSize(16).color(context.primary),
                ],
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

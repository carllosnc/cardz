import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';

showErrorSheet(BuildContext context, FlashError error) {
  return VWSheet.open(
    isScrollControlled: false,
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    appBar: AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      title: error.title.pageTitle,
    ),
    context: context,
    body: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: VWColumn(
          gap: 20,
          horizontalAlignment: CrossAxisAlignment.center,
          verticalAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(25),
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 30,
            ),
            error.details.text.center.fontSize(16),
          ],
        ),
      ),
    ),
  );
}

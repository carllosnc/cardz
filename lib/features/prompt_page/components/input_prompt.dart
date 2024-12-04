// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import './error_sheet.dart';

class InputPrompt extends StatefulWidget {
  final Language languageToLearn;
  final Function onAdd;

  const InputPrompt({
    super.key,
    required this.languageToLearn,
    required this.onAdd,
  });

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> with SharedState, LocalizeMixin {
  final inputController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  submitAction(value, context) async {
    var resultAsJson;

    if (value.isEmpty || value == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: 'please enter a word or sentence'.localize.text.color(Colors.white).center,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    var result = await gemini(
      apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
      prompt: geminiPrompt(
        sentence: value,
        languageToLearn: widget.languageToLearn.name,
        languageToTranslate: localizeState.currentLanguage,
      ),
    );

    try {
      resultAsJson = jsonDecode(result);
    } on FormatException {
      resultAsJson = {
        'hasError': true,
        'title': 'Internal error'.localize,
        'details': result.toString(),
        'suggestion': 'Please try again later',
      };
    } on Exception catch (e) {
      resultAsJson = {
        'hasError': true,
        'title': 'Internal error'.localize,
        'details': e.toString(),
        'suggestion': 'Please try again later',
      };
    }

    if (context.mounted) {
      FocusScope.of(context).unfocus();
      inputController.clear();

      setState(() {
        isLoading = false;
      });

      if (resultAsJson['hasError'] == true) {
        showErrorSheet(context, FlashError.fromJson(resultAsJson));
        return;
      }

      final flashCard = FlashContent.fromJson(resultAsJson);

      await database.createFlashContent(
        flashContent: flashCard,
        language: widget.languageToLearn,
      );

      widget.onAdd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VWBox(
      height: 70,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: VWColumn(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              backgroundColor: const Color.fromARGB(0, 74, 50, 50),
              minHeight: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
          VWBox(
            child: Form(
              key: globalKey,
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 18,
                ),
                enabled: !isLoading,
                controller: inputController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorStyle: const TextStyle(fontSize: 0.01),
                  contentPadding: const EdgeInsets.fromLTRB(20, 28, 28, 0),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'write a word or sentence'.localize,
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onFieldSubmitted: (value) {
                  submitAction(value, context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

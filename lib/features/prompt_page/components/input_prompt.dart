// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import './error_sheet.dart';

class InputPrompt extends StatefulWidget {
  final Language languageToLearn;

  const InputPrompt({
    super.key,
    required this.languageToLearn,
  });

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> with SharedState, LocalizeMixin {
  final inputController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  submitHandler(value, context) async {
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

    var resultAsJson;

    try {
      resultAsJson = jsonDecode(result);
    } catch (e) {
      resultAsJson = {
        'hasError': true,
        'title': 'Internal error',
        'details': "Something went wrong, please try again later. Sometimes the content doesn't come in the right format, or the api key is invalid",
        'suggestion': 'Please try again later',
      };
    }

    if (context.mounted) {
      FocusScope.of(context).unfocus();
      inputController.clear();

      setState(() {
        isLoading = false;
      });

      log(resultAsJson.toString());

      if (resultAsJson['hasError'] == true) {
        showErrorSheet(context, FlashError.fromJson(resultAsJson));
        return;
      }

      final flashCard = FlashContent.fromJson(resultAsJson);

      database.createFlashContent(
        flashContent: flashCard,
        language: widget.languageToLearn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return VWBox(
      height: 80,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: VWColumn(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              minHeight: 1,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
          VWBox(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Form(
              key: globalKey,
              child: TextFormField(
                enabled: !isLoading,
                controller: inputController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                    fontSize: 0.01,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  hintText: 'write a word or sentence'.localize,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onFieldSubmitted: (value) {
                  submitHandler(value, context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

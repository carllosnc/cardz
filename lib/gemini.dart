import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> gemini({
  required String apiKey,
  required String prompt,
}) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  try {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text.toString();
  } catch (e) {
    return {
      'hasError': true,
      'title': 'Internal error',
      'details': "Something went wrong, please try again later. Sometimes the content doesn't come in the right format, or the api key is invalid",
      'suggestion': 'Please try again later',
    }.toString();
  }
}

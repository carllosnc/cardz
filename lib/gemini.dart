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
  } on GenerativeAIException catch (e) {
    return e.message.toString();
  } on GenerativeAISdkException catch (e) {
    return e.message.toString();
  } catch (e) {
    return e.toString();
  }
}

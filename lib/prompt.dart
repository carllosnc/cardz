languagePrompt({
  String languageToLearn = 'english',
  String languageToTranslate = 'portuguese',
  required String sentence,
}) {
  return '''
    Generate a language learning flashcard for the following input:

    Input Parameters:
    - Target Learning Language: $languageToLearn
    - Source Text: "$sentence"
    - Translation Language: $languageToTranslate

    Requirements:
    1. If the input is in $languageToTranslate, translate to $languageToLearn first and proceed
    2. Don't wrap the result json in ```json```
    3. Generate all content in the following format:
    {
      "languageToLearn": "$languageToLearn",
      "word": "original word or phrase",
      "emoji": "relevant emoji",
      "category": "grammatical category or type",
      "pronunciation": "if applicable",
      "meaning": "meaning in $languageToLearn",
      "translation": "translation in $languageToTranslate",
      "descriptionGrammar": "grammatical explanation in $languageToTranslate",
      "descriptionUsage": "usage notes and context in $languageToTranslate",
      "descriptionCultural": "cultural context if relevant in $languageToTranslate",
      "synonyms": ["array", "of", "3-5", "synonyms"],
      "sentences": [
        "sentence in $languageToLearn - translation in $languageToTranslate"
      ]
    }

    3. For any errors, respond with:
    {
      "hasError": true,
      "title": "brief error title",
      "details": "detailed explanation",
      "suggestion": "how to fix the error"
    }

    Validation Rules:
    1. Sentence must not be empty
    2. Languages must be supported
    3. Content must be appropriate for learning
    4. Examples must be contextually relevant
    5. Minimum 3 and maximum 5 example sentences required
  ''';
}

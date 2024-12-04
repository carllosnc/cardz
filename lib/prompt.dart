String geminiPrompt({
  String languageToTranslate = 'portuguese',
  required String languageToLearn,
  required String sentence,
}) {
  return '''
    Generate a language learning flashcard for the following input:

    Input Parameters:
    - Target Learning Language: $languageToLearn
    - Source Text: "$sentence"
    - Translation Language: $languageToTranslate

    Requirements:
    1. First of all, if the input is write in any other language, translate it to $languageToTranslate and proced.
    2. Don't wrap the result json in ```json```
    3. Generate all content in the following format:
    {
      "languageToLearn": "$languageToLearn",
      "word": "original word or phrase in $languageToLearn",
      "emoji": "relevant emoji",
      "category": "grammatical category or type in $languageToTranslate",
      "pronunciation": "if applicable",
      "meaning": "meaning in $languageToLearn",
      "translation": "translation in $languageToTranslate",
      "descriptionGrammar": "grammatical explanation in $languageToTranslate",
      "descriptionUsage": "usage notes and context in $languageToTranslate",
      "descriptionCultural": "cultural context if relevant in $languageToTranslate",
      "synonyms": ["array", "of", "3-5", "synonyms"],
      "examples": [
        "example in $languageToLearn - translation in $languageToTranslate"
      ]
    }

    Validation Rules:
    1. First of all, if the word or sentence is not comprehensible, return a error
    2. For any violation or safety concerns, return a error
    3. Sentence must not be empty
    4. Languages must be supported
    5. Content must be appropriate for learning
    6. Examples must be contextually relevant
    7. Minimum 10 and maximum 15 examples required
    8. All descriptions must be in $languageToTranslate

    Error Response:
    1. For any error, return the following json:
    {
      "hasError": true,
      "title": "brief error title in $languageToTranslate",
      "details": "detailed explanation in $languageToTranslate",
      "suggestion": "how to fix the error in $languageToTranslate"
    }
  ''';
}

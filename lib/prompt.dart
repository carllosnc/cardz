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

    3. For any errors, respond with:
    {
      "hasError": true,
      "title": "brief error title in $languageToTranslate",
      "details": "detailed explanation in $languageToTranslate",
    }

    Validation Rules:
    1. Sentence must not be empty
    2. Languages must be supported
    3. Content must be appropriate for learning
    4. Examples must be contextually relevant
    5. Minimum 3 and maximum 5 examples required
    6. All descriptions must be in $languageToTranslate
    7. If the word or sentence is not comprehensible, return a error
  ''';
}

extension StringExtension on String {
  String sanitizeJson() {
    return replaceAll('```json', ' ').replaceAll('```', '');
  }
}

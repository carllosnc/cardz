extension StringExtension on String {
  String sanitizeJson() {
    return replaceAll('```json', ' ').replaceAll('```', '');
  }

  String pluralize(int? length) {
    if (length == null) return this;
    return length == 1 ? this : '${this}s';
  }
}

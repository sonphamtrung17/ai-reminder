extension StringExtensions on String? {
  String plus(String other) {
    return (this ?? '') + other;
  }

  bool equalsIgnoreCase(String secondString) =>
      (this ?? '').toLowerCase().contains(secondString.toLowerCase());

  bool get isEmptyOrNull => this == null || this!.isEmpty;
}

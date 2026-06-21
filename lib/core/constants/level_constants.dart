enum LanguageLevel {
  a1,
  a2,
  b1,
  b2,
  c1;

  String get label {
    switch (this) {
      case LanguageLevel.a1:
        return 'A1 - مبتدئ';
      case LanguageLevel.a2:
        return 'A2 - ابتدائي';
      case LanguageLevel.b1:
        return 'B1 - متوسط';
      case LanguageLevel.b2:
        return 'B2 - فوق المتوسط';
      case LanguageLevel.c1:
        return 'C1 - متقدم';
    }
  }

  String get shortLabel => name.toUpperCase();
}

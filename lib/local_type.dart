enum LocaleType {
  en('en', 'English'),
  es('es', 'Spanish'),
  fr('fr', 'French'),
  cl('cl', 'Custom Locale');

  const LocaleType(this.locale, this.name);

  final String locale;
  final String name;
}

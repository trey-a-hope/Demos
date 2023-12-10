enum LocaleType {
  en('en', 'English'),
  es('es', 'Spanish'),
  fr('fr', 'French');

  const LocaleType(this.locale, this.name);

  final String locale;
  final String name;
}

enum LocaleType {
  en('en', 'English'),
  enShort('en_short', 'English Short'),
  es('es', 'Spanish'),
  fr('fr', 'French');

  const LocaleType(this.locale, this.name);

  final String locale;
  final String name;
}

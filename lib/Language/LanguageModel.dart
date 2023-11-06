class Language {
  int id;
  String name;
  String languageCode;
  String flag;

  Language(this.id, this.name, this.languageCode, this.flag);

  static List<Language> getLanguages() {
    return <Language>[
      Language(0, 'English', 'en', 'Images/News/flags/ic_us.png'),
      Language(6, 'Indonesian', 'id', 'Images/News/flags/ic_indonesia.png'),

    ];
  }
}

import 'package:flutter/material.dart';
import 'package:mni/localization/language/language_ar.dart';
import 'package:mni/localization/language/language_en.dart';
import 'package:mni/localization/language/language_fr.dart';
import 'package:mni/localization/language/language_se.dart';
import 'package:mni/localization/language/language_tr.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'fr','tr','sv',].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'fr':
        return LanguageFr();
      case 'tr':
        return LanguageTr();
      case 'sv':
        return LanguageSe();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

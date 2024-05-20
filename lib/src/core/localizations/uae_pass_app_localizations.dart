import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class UaePassAppLocalizations {
  final Locale locale;

  UaePassAppLocalizations({
    required this.locale,
  });

  static UaePassAppLocalizations of(BuildContext context) =>
      Localizations.of<UaePassAppLocalizations>(
          context, UaePassAppLocalizations)!;

  static const LocalizationsDelegate<UaePassAppLocalizations> delegate =
      _AppLocalizationsDelegate();
  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // String jsonString = await rootBundle
    //     .loadString('packages/uae_pass/lang/lang_${locale.languageCode}.json');
    ByteData bytes = await rootBundle
        .load('packages/uae_pass/assets/lang/lang_${locale.languageCode}.json');
    String jsonString = utf8.decode(bytes.buffer.asUint8List());

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) => _localizedStrings[key] ?? "";
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<UaePassAppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<UaePassAppLocalizations> load(Locale locale) async {
    UaePassAppLocalizations localizations =
        UaePassAppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<UaePassAppLocalizations> old) => true;
}

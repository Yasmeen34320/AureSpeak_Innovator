import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en';
  runApp(MyApp());
}

// Define your localized strings for each language
Map<String, Map<String, String>> localizedStrings = {
  'en': {
    'title': 'Flutter Localization Demo',
    'helloWorld': 'Hello World!',
    'switchToEnglish': 'Switch to English',
    'switchToArabic': 'Switch to Arabic',
  },
  'ar': {
    'title': 'توضيحات الترجمة في Flutter',
    'helloWorld': 'مرحبًا بكم في العالم',
    'switchToEnglish': 'تبديل إلى الإنجليزية',
    'switchToArabic': 'تبديل إلى العربية',
  },
};

// Define a function that will return the current localized strings based on the provided locale
AppLocalizations appLocalizations(BuildContext context) {
  final locale =
      Provider.of<ChangeLocaleProvider>(context, listen: false).locale;
  final localeCode = locale.languageCode;
  return AppLocalizations(localeCode);
}

class AppLocalizations {
  final String _localeCode;

  AppLocalizations(this._localeCode);

  String get title => _getTranslation('title');
  String get helloWorld => _getTranslation('helloWorld');
  String get switchToEnglish => _getTranslation('switchToEnglish');
  String get switchToArabic => _getTranslation('switchToArabic');

  String _getTranslation(String key) {
    final locale = Intl.canonicalizedLocale(_localeCode);
    return localizedStrings[locale]?.containsKey(key) == true
        ? localizedStrings[locale]![key]!
        : 'Localization key not found: $key';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangeLocaleProvider(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'), // English
          Locale('ar', 'AR'), // Arabic
        ],
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeLocaleProvider = Provider.of<ChangeLocaleProvider>(context);

    // final appLocalizations =
    //     AppLocalizations(Localizations.localeOf(context) as String);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations(context).helloWorld,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                // Change app language to English
                changeLocaleProvider.setLocale(Locale('en', 'EN'));
              },
              child: Text(appLocalizations(context).switchToEnglish),
            ),
            ElevatedButton(
              onPressed: () {
                // Change app language to Arabic
                changeLocaleProvider.setLocale(Locale('ar', 'AR'));
              },
              child: Text(appLocalizations(context).switchToArabic),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeLocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

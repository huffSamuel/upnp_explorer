// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `View Formatted`
  String get viewFormatted {
    return Intl.message(
      'View Formatted',
      name: 'viewFormatted',
      desc: '',
      args: [],
    );
  }

  /// `View Raw`
  String get viewRaw {
    return Intl.message(
      'View Raw',
      name: 'viewRaw',
      desc: '',
      args: [],
    );
  }

  /// `Response`
  String get response {
    return Intl.message(
      'Response',
      name: 'response',
      desc: '',
      args: [],
    );
  }

  /// `Device Description`
  String get deviceDescription {
    return Intl.message(
      'Device Description',
      name: 'deviceDescription',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get na {
    return Intl.message(
      'N/A',
      name: 'na',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String version(Object version) {
    return Intl.message(
      'Version $version',
      name: 'version',
      desc: '',
      args: [version],
    );
  }

  /// `About {appName}`
  String aboutApp(Object appName) {
    return Intl.message(
      'About $appName',
      name: 'aboutApp',
      desc: '',
      args: [appName],
    );
  }

  /// `Display`
  String get display {
    return Intl.message(
      'Display',
      name: 'display',
      desc: '',
      args: [],
    );
  }

  /// `Density`
  String get density {
    return Intl.message(
      'Density',
      name: 'density',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Submit Bug`
  String get submitBug {
    return Intl.message(
      'Submit Bug',
      name: 'submitBug',
      desc: '',
      args: [],
    );
  }

  /// `DeviceDocument`
  String get deviceDocument {
    return Intl.message(
      'DeviceDocument',
      name: 'deviceDocument',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
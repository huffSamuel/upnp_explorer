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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `SSDP Protocol`
  String get ssdpProtocol {
    return Intl.message(
      'SSDP Protocol',
      name: 'ssdpProtocol',
      desc: '',
      args: [],
    );
  }

  /// `Multicast Hops`
  String get multicastHops {
    return Intl.message(
      'Multicast Hops',
      name: 'multicastHops',
      desc: '',
      args: [],
    );
  }

  /// `The maximum network hops for multicast packages originating from this device.`
  String get multicastHopsDescription {
    return Intl.message(
      'The maximum network hops for multicast packages originating from this device.',
      name: 'multicastHopsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Choose theme`
  String get chooseTheme {
    return Intl.message(
      'Choose theme',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `{themeMode, select, light {Light} dark {Dark} system {System Defined}}`
  String themeMode(Object themeMode) {
    return Intl.select(
      themeMode,
      {
        'light': 'Light',
        'dark': 'Dark',
        'system': 'System Defined',
      },
      name: 'themeMode',
      desc: '',
      args: [themeMode],
    );
  }

  /// `{visualDensity, select, comfortable {Comfortable} standard {Standard} compact {Compact} other {Unknown}}`
  String visualDensity(Object visualDensity) {
    return Intl.select(
      visualDensity,
      {
        'comfortable': 'Comfortable',
        'standard': 'Standard',
        'compact': 'Compact',
        'other': 'Unknown',
      },
      name: 'visualDensity',
      desc: '',
      args: [visualDensity],
    );
  }

  /// `{seconds} seconds`
  String responseDelay(Object seconds) {
    return Intl.message(
      '$seconds seconds',
      name: 'responseDelay',
      desc: '',
      args: [seconds],
    );
  }

  /// `Maximum Response Delay`
  String get maxResponseDelay {
    return Intl.message(
      'Maximum Response Delay',
      name: 'maxResponseDelay',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Mode`
  String get advancedMode {
    return Intl.message(
      'Advanced Mode',
      name: 'advancedMode',
      desc: '',
      args: [],
    );
  }

  /// `Allow longer delay response`
  String get advancedModeDescription {
    return Intl.message(
      'Allow longer delay response',
      name: 'advancedModeDescription',
      desc: '',
      args: [],
    );
  }

  /// `The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.`
  String get maxDelayDescription {
    return Intl.message(
      'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.',
      name: 'maxDelayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Unable to submit feedback`
  String get unableToSubmitFeedback {
    return Intl.message(
      'Unable to submit feedback',
      name: 'unableToSubmitFeedback',
      desc: '',
      args: [],
    );
  }

  /// `App Feedback`
  String get mailSubject {
    return Intl.message(
      'App Feedback',
      name: 'mailSubject',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String mailBody(Object version) {
    return Intl.message(
      'Version $version',
      name: 'mailBody',
      desc: '',
      args: [version],
    );
  }

  /// `No devices found.`
  String get noDevicesFound {
    return Intl.message(
      'No devices found.',
      name: 'noDevicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Device discovery requires network access`
  String get discoveryRequiresNetwork {
    return Intl.message(
      'Device discovery requires network access',
      name: 'discoveryRequiresNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Turn on WiFi`
  String get turnOnWifi {
    return Intl.message(
      'Turn on WiFi',
      name: 'turnOnWifi',
      desc: '',
      args: [],
    );
  }

  /// `Actions {count}`
  String actionsN(Object count) {
    return Intl.message(
      'Actions $count',
      name: 'actionsN',
      desc: '',
      args: [count],
    );
  }

  /// `State Variables {count}`
  String stateVariablesN(Object count) {
    return Intl.message(
      'State Variables $count',
      name: 'stateVariablesN',
      desc: '',
      args: [count],
    );
  }

  /// `Manufacturer`
  String get manufacturer {
    return Intl.message(
      'Manufacturer',
      name: 'manufacturer',
      desc: '',
      args: [],
    );
  }

  /// `Model Name`
  String get modelName {
    return Intl.message(
      'Model Name',
      name: 'modelName',
      desc: '',
      args: [],
    );
  }

  /// `Model Number`
  String get modelNumber {
    return Intl.message(
      'Model Number',
      name: 'modelNumber',
      desc: '',
      args: [],
    );
  }

  /// `Model Description`
  String get modelDescription {
    return Intl.message(
      'Model Description',
      name: 'modelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Serial Number`
  String get serialNumber {
    return Intl.message(
      'Serial Number',
      name: 'serialNumber',
      desc: '',
      args: [],
    );
  }

  /// `Services {count}`
  String servicesN(Object count) {
    return Intl.message(
      'Services $count',
      name: 'servicesN',
      desc: '',
      args: [count],
    );
  }

  /// `Devices {count}`
  String devicesN(Object count) {
    return Intl.message(
      'Devices $count',
      name: 'devicesN',
      desc: '',
      args: [count],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Unable to obtain service information`
  String get unableToObtainInformation {
    return Intl.message(
      'Unable to obtain service information',
      name: 'unableToObtainInformation',
      desc: '',
      args: [],
    );
  }

  /// `State Variables`
  String get stateVariables {
    return Intl.message(
      'State Variables',
      name: 'stateVariables',
      desc: '',
      args: [],
    );
  }

  /// `Control Unavailable`
  String get controlUnavailable {
    return Intl.message(
      'Control Unavailable',
      name: 'controlUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `UPnP service control is unavailable at this time.`
  String get serviceControlUnavailable {
    return Intl.message(
      'UPnP service control is unavailable at this time.',
      name: 'serviceControlUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `, `
  String get listSeparator {
    return Intl.message(
      ', ',
      name: 'listSeparator',
      desc: '',
      args: [],
    );
  }

  /// `I take your privacy very seriously. Beyond the information Google provides to app developers, I use no third-party analytics or advertising frameworks. I log no information on you and have no interest in doing so.\n\nI do not collect, transmit, distribute, or sell your data.`
  String get legalese {
    return Intl.message(
      'I take your privacy very seriously. Beyond the information Google provides to app developers, I use no third-party analytics or advertising frameworks. I log no information on you and have no interest in doing so.\n\nI do not collect, transmit, distribute, or sell your data.',
      name: 'legalese',
      desc: '',
      args: [],
    );
  }

  /// `Open presentation URL in browser`
  String get openPresentationInBrowser {
    return Intl.message(
      'Open presentation URL in browser',
      name: 'openPresentationInBrowser',
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
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

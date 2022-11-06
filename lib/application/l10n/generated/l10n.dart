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

  /// `Sent at {time}`
  String sentAt(Object time) {
    return Intl.message(
      'Sent at $time',
      name: 'sentAt',
      desc: '',
      args: [time],
    );
  }

  /// `Received at {time}`
  String receivedAt(Object time) {
    return Intl.message(
      'Received at $time',
      name: 'receivedAt',
      desc: '',
      args: [time],
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

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Actions ({count})`
  String actionsN(Object count) {
    return Intl.message(
      'Actions ($count)',
      name: 'actionsN',
      desc: '',
      args: [count],
    );
  }

  /// `Advanced mode`
  String get advancedMode {
    return Intl.message(
      'Advanced mode',
      name: 'advancedMode',
      desc: '',
      args: [],
    );
  }

  /// `Advanced mode allows delays longer than recommended. Enabling advanced mode may have negative affects.`
  String get advancedModeWarning {
    return Intl.message(
      'Advanced mode allows delays longer than recommended. Enabling advanced mode may have negative affects.',
      name: 'advancedModeWarning',
      desc: '',
      args: [],
    );
  }

  /// `Changelog`
  String get changelog {
    return Intl.message(
      'Changelog',
      name: 'changelog',
      desc: '',
      args: [],
    );
  }

  /// `- {item}`
  String changelogItem(Object item) {
    return Intl.message(
      '- $item',
      name: 'changelogItem',
      desc: '',
      args: [item],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
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

  /// `Copied!`
  String get copied {
    return Intl.message(
      'Copied!',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme uses a black background to help keep your battery alive longer.`
  String get darkThemeDescription {
    return Intl.message(
      'Dark theme uses a black background to help keep your battery alive longer.',
      name: 'darkThemeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Decrease`
  String get decrease {
    return Intl.message(
      'Decrease',
      name: 'decrease',
      desc: '',
      args: [],
    );
  }

  /// `Decrease disabled`
  String get decreaseDisabled {
    return Intl.message(
      'Decrease disabled',
      name: 'decreaseDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Visual density`
  String get density {
    return Intl.message(
      'Visual density',
      name: 'density',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get devices {
    return Intl.message(
      'Devices',
      name: 'devices',
      desc: '',
      args: [],
    );
  }

  /// `Devices ({count})`
  String devicesN(Object count) {
    return Intl.message(
      'Devices ($count)',
      name: 'devicesN',
      desc: '',
      args: [count],
    );
  }

  /// `{direction, select, incoming {Incoming} outgoing {Outgoing}}`
  String direction(Object direction) {
    return Intl.select(
      direction,
      {
        'incoming': 'Incoming',
        'outgoing': 'Outgoing',
      },
      name: 'direction',
      desc: '',
      args: [direction],
    );
  }

  /// `Discovered device {name}`
  String discoveredDevice(Object name) {
    return Intl.message(
      'Discovered device $name',
      name: 'discoveredDevice',
      desc: '',
      args: [name],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Discovery`
  String get discovery {
    return Intl.message(
      'Discovery',
      name: 'discovery',
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

  /// `Display`
  String get display {
    return Intl.message(
      'Display',
      name: 'display',
      desc: '',
      args: [],
    );
  }

  /// `Found a bug?`
  String get foundBug {
    return Intl.message(
      'Found a bug?',
      name: 'foundBug',
      desc: '',
      args: [],
    );
  }

  /// `From {address}`
  String fromAddress(Object address) {
    return Intl.message(
      'From $address',
      name: 'fromAddress',
      desc: '',
      args: [address],
    );
  }

  /// `Increase`
  String get increase {
    return Intl.message(
      'Increase',
      name: 'increase',
      desc: '',
      args: [],
    );
  }

  /// `Increase disabled`
  String get increaseDisabled {
    return Intl.message(
      'Increase disabled',
      name: 'increaseDisabled',
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

  /// `Let us know how we're doing`
  String get letUsKnowHowWereDoing {
    return Intl.message(
      'Let us know how we\'re doing',
      name: 'letUsKnowHowWereDoing',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message(
      'Licenses',
      name: 'licenses',
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

  /// `Version {version}`
  String mailBody(Object version) {
    return Intl.message(
      'Version $version',
      name: 'mailBody',
      desc: '',
      args: [version],
    );
  }

  /// `App feedback`
  String get mailSubject {
    return Intl.message(
      'App feedback',
      name: 'mailSubject',
      desc: '',
      args: [],
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

  /// `The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.`
  String get maxDelayDescription {
    return Intl.message(
      'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.',
      name: 'maxDelayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Maximum response delay`
  String get maxResponseDelay {
    return Intl.message(
      'Maximum response delay',
      name: 'maxResponseDelay',
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

  /// `Multicast hops`
  String get multicastHops {
    return Intl.message(
      'Multicast hops',
      name: 'multicastHops',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of network hops for multicast packages originating from this device.`
  String get multicastHopsDescription {
    return Intl.message(
      'Maximum number of network hops for multicast packages originating from this device.',
      name: 'multicastHopsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Never ask again`
  String get neverAskAgain {
    return Intl.message(
      'Never ask again',
      name: 'neverAskAgain',
      desc: '',
      args: [],
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

  /// `Not now`
  String get notNow {
    return Intl.message(
      'Not now',
      name: 'notNow',
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

  /// `Open an issue on our GitHub`
  String get openAnIssueOnOurGithub {
    return Intl.message(
      'Open an issue on our GitHub',
      name: 'openAnIssueOnOurGithub',
      desc: '',
      args: [],
    );
  }

  /// `Open in browser`
  String get openInBrowser {
    return Intl.message(
      'Open in browser',
      name: 'openInBrowser',
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

  /// `If you like {appName}, or you've found something we need to work on, we would love to hear about it. We would greatly appreciate it if you could rate the app on the Play Store. Thanks!`
  String pleaseRateAppName(Object appName) {
    return Intl.message(
      'If you like $appName, or you\'ve found something we need to work on, we would love to hear about it. We would greatly appreciate it if you could rate the app on the Play Store. Thanks!',
      name: 'pleaseRateAppName',
      desc: '',
      args: [appName],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `{protocol, select, upnp {UPnP} ssdp {SSDP} soap {SOAP}}`
  String protocol(Object protocol) {
    return Intl.select(
      protocol,
      {
        'upnp': 'UPnP',
        'ssdp': 'SSDP',
        'soap': 'SOAP',
      },
      name: 'protocol',
      desc: '',
      args: [protocol],
    );
  }

  /// `Rate {appName}`
  String rateAppName(Object appName) {
    return Intl.message(
      'Rate $appName',
      name: 'rateAppName',
      desc: '',
      args: [appName],
    );
  }

  /// `Rate on Google Play`
  String get rateOnGooglePlay {
    return Intl.message(
      'Rate on Google Play',
      name: 'rateOnGooglePlay',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
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

  /// `Scanning for devices`
  String get scanningForDevices {
    return Intl.message(
      'Scanning for devices',
      name: 'scanningForDevices',
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

  /// `UPnP service control is unavailable at this time.`
  String get serviceControlUnavailable {
    return Intl.message(
      'UPnP service control is unavailable at this time.',
      name: 'serviceControlUnavailable',
      desc: '',
      args: [],
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

  /// `Services ({count})`
  String servicesN(Object count) {
    return Intl.message(
      'Services ($count)',
      name: 'servicesN',
      desc: '',
      args: [count],
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

  /// `State Variables`
  String get stateVariables {
    return Intl.message(
      'State Variables',
      name: 'stateVariables',
      desc: '',
      args: [],
    );
  }

  /// `State Variables ({count})`
  String stateVariablesN(Object count) {
    return Intl.message(
      'State Variables ($count)',
      name: 'stateVariablesN',
      desc: '',
      args: [count],
    );
  }

  /// `System default theme uses your device's settings to determine when to use light or dark mode.`
  String get systemThemeDescription {
    return Intl.message(
      'System default theme uses your device\'s settings to determine when to use light or dark mode.',
      name: 'systemThemeDescription',
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

  /// `{themeMode, select, light {Light} dark {Dark} system {System Default}}`
  String themeMode(Object themeMode) {
    return Intl.select(
      themeMode,
      {
        'light': 'Light',
        'dark': 'Dark',
        'system': 'System Default',
      },
      name: 'themeMode',
      desc: '',
      args: [themeMode],
    );
  }

  /// `Traffic`
  String get traffic {
    return Intl.message(
      'Traffic',
      name: 'traffic',
      desc: '',
      args: [],
    );
  }

  /// `Turn on Wi-Fi`
  String get turnOnWifi {
    return Intl.message(
      'Turn on Wi-Fi',
      name: 'turnOnWifi',
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

  /// `Unable to submit feedback`
  String get unableToSubmitFeedback {
    return Intl.message(
      'Unable to submit feedback',
      name: 'unableToSubmitFeedback',
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

  /// `Version {version}`
  String version(Object version) {
    return Intl.message(
      'Version $version',
      name: 'version',
      desc: '',
      args: [version],
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

  /// `What's new`
  String get whatsNew {
    return Intl.message(
      'What\'s new',
      name: 'whatsNew',
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

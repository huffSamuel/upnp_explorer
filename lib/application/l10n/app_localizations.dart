import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @contributors.
  ///
  /// In en, this message translates to:
  /// **'Contributors'**
  String get contributors;

  /// No description provided for @aSpecialThanks.
  ///
  /// In en, this message translates to:
  /// **'A special thanks!'**
  String get aSpecialThanks;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @directionDescription.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get directionDescription;

  /// No description provided for @protocolDescription.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get protocolDescription;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @aboutThisDevice.
  ///
  /// In en, this message translates to:
  /// **'About this device'**
  String get aboutThisDevice;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @noActionsForThisService.
  ///
  /// In en, this message translates to:
  /// **'No actions for this service'**
  String get noActionsForThisService;

  /// No description provided for @sendCommand.
  ///
  /// In en, this message translates to:
  /// **'Send {name} command'**
  String sendCommand(Object name);

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Actions
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @actionsN.
  ///
  /// In en, this message translates to:
  /// **'Actions ({count})'**
  String actionsN(num count);

  /// No description provided for @countVisible.
  ///
  /// In en, this message translates to:
  /// **'{count} visible'**
  String countVisible(num count);

  /// No description provided for @adaptiveLayout.
  ///
  /// In en, this message translates to:
  /// **'Adaptive layout'**
  String get adaptiveLayout;

  /// No description provided for @adaptiveLayoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Adapt the layout and color scheme of the app to the platform\'s operating system and dynamic color settings.'**
  String get adaptiveLayoutDescription;

  /// No description provided for @advancedMode.
  ///
  /// In en, this message translates to:
  /// **'Advanced mode'**
  String get advancedMode;

  /// Message to warn users of the dangers of enabling advanced mode.
  ///
  /// In en, this message translates to:
  /// **'Advanced mode allows delays longer than recommended. Enabling advanced mode may have negative affects.'**
  String get advancedModeWarning;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @changelog.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get changelog;

  /// A single changelog line item
  ///
  /// In en, this message translates to:
  /// **'- {item}'**
  String changelogItem(String item);

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Yes, clear history'**
  String get clearHistory;

  /// No description provided for @clearMessages.
  ///
  /// In en, this message translates to:
  /// **'Clear Messages?'**
  String get clearMessages;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @commandFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Command failed {error}'**
  String commandFailedWithError(String error);

  /// No description provided for @controlUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Control Unavailable'**
  String get controlUnavailable;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copyJson.
  ///
  /// In en, this message translates to:
  /// **'Copy JSON'**
  String get copyJson;

  /// No description provided for @darkThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Dark theme uses a black background to help keep your battery alive longer.'**
  String get darkThemeDescription;

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @decreaseDisabled.
  ///
  /// In en, this message translates to:
  /// **'Decrease disabled'**
  String get decreaseDisabled;

  /// No description provided for @density.
  ///
  /// In en, this message translates to:
  /// **'Visual density'**
  String get density;

  /// No description provided for @devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devices;

  /// No description provided for @devicesN.
  ///
  /// In en, this message translates to:
  /// **'Devices ({count})'**
  String devicesN(num count);

  /// Display name for a `Direction`
  ///
  /// In en, this message translates to:
  /// **'{direction, select, incoming {Received} outgoing {Sent} other {Unknown}}'**
  String direction(String direction);

  /// No description provided for @discoveredDevice.
  ///
  /// In en, this message translates to:
  /// **'Discovered device {name}'**
  String discoveredDevice(String name);

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get discovery;

  /// No description provided for @discoveryRequiresNetwork.
  ///
  /// In en, this message translates to:
  /// **'Device discovery requires network access'**
  String get discoveryRequiresNetwork;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @foundBug.
  ///
  /// In en, this message translates to:
  /// **'Found a bug?'**
  String get foundBug;

  /// No description provided for @fromAddress.
  ///
  /// In en, this message translates to:
  /// **'From {address}'**
  String fromAddress(String address);

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @increaseDisabled.
  ///
  /// In en, this message translates to:
  /// **'Increase disabled'**
  String get increaseDisabled;

  /// No description provided for @input.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get input;

  /// No description provided for @keepHistory.
  ///
  /// In en, this message translates to:
  /// **'No, keep history'**
  String get keepHistory;

  /// No description provided for @knownValue.
  ///
  /// In en, this message translates to:
  /// **'{name} {value}'**
  String knownValue(String name, String value);

  /// No description provided for @legalese.
  ///
  /// In en, this message translates to:
  /// **'I take your privacy very seriously. Beyond the information Google provides to app developers, I use no third-party analytics or advertising frameworks. I log no information on you and have no interest in doing so.\n\nI do not collect, transmit, distribute, or sell your data.'**
  String get legalese;

  /// No description provided for @letUsKnowHowWereDoing.
  ///
  /// In en, this message translates to:
  /// **'Let us know how we\'re doing'**
  String get letUsKnowHowWereDoing;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @listSeparator.
  ///
  /// In en, this message translates to:
  /// **', '**
  String get listSeparator;

  /// No description provided for @mailBody.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String mailBody(String version);

  /// No description provided for @mailSubject.
  ///
  /// In en, this message translates to:
  /// **'App feedback'**
  String get mailSubject;

  /// No description provided for @manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get manufacturer;

  /// No description provided for @maxDelayDescription.
  ///
  /// In en, this message translates to:
  /// **'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.'**
  String get maxDelayDescription;

  /// No description provided for @maxResponseDelay.
  ///
  /// In en, this message translates to:
  /// **'Response delay'**
  String get maxResponseDelay;

  /// No description provided for @messageLog.
  ///
  /// In en, this message translates to:
  /// **'{type} {direction, select, inn {received} out {sent} other {Unknown}} at {time}'**
  String messageLog(String direction, String time, String type);

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @modelDescription.
  ///
  /// In en, this message translates to:
  /// **'Model Description'**
  String get modelDescription;

  /// No description provided for @modelName.
  ///
  /// In en, this message translates to:
  /// **'Model Name'**
  String get modelName;

  /// No description provided for @modelNumber.
  ///
  /// In en, this message translates to:
  /// **'Model Number'**
  String get modelNumber;

  /// No description provided for @multicastHops.
  ///
  /// In en, this message translates to:
  /// **'Multicast hops'**
  String get multicastHops;

  /// No description provided for @multicastHopsDescription.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of network hops for multicast packages originating from this device.'**
  String get multicastHopsDescription;

  /// No description provided for @neverAskAgain.
  ///
  /// In en, this message translates to:
  /// **'Never ask again'**
  String get neverAskAgain;

  /// No description provided for @noDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found.'**
  String get noDevicesFound;

  /// No description provided for @nothingHere.
  ///
  /// In en, this message translates to:
  /// **'There\'s nothing here.'**
  String get nothingHere;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @openAnIssueOnOurGithub.
  ///
  /// In en, this message translates to:
  /// **'Open an issue on our GitHub'**
  String get openAnIssueOnOurGithub;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open XML in browser'**
  String get openInBrowser;

  /// No description provided for @openPresentationInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open presentation URL in browser'**
  String get openPresentationInBrowser;

  /// No description provided for @output.
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get output;

  /// Request the user to rate the app.
  ///
  /// In en, this message translates to:
  /// **'If you like {appName}, or you\'ve found something we need to work on, we would love to hear about it. We would greatly appreciate it if you could rate the app on the Play Store. Thanks!'**
  String pleaseRateAppName(String appName);

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// Display name for a message `Protocol`
  ///
  /// In en, this message translates to:
  /// **'{protocol, select, upnp {UPnP} ssdp {SSDP} soap {SOAP} http {HTTP} other {Unknown}}'**
  String protocol(String protocol);

  /// No description provided for @rateAppName.
  ///
  /// In en, this message translates to:
  /// **'Rate {appName}'**
  String rateAppName(String appName);

  /// No description provided for @rateOnGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Rate on Google Play'**
  String get rateOnGooglePlay;

  /// No description provided for @receivedAt.
  ///
  /// In en, this message translates to:
  /// **'Received at {time}'**
  String receivedAt(DateTime time);

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// A number of seconds
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 second} other{{count} seconds}}'**
  String responseDelay(num count);

  /// No description provided for @scanningForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for devices'**
  String get scanningForDevices;

  /// No description provided for @sentAt.
  ///
  /// In en, this message translates to:
  /// **'at {time}'**
  String sentAt(DateTime time);

  /// No description provided for @serialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serialNumber;

  /// No description provided for @serviceControlUnavailable.
  ///
  /// In en, this message translates to:
  /// **'UPnP service control is unavailable at this time.'**
  String get serviceControlUnavailable;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @servicesN.
  ///
  /// In en, this message translates to:
  /// **'Services ({count})'**
  String servicesN(num count);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @stateVariables.
  ///
  /// In en, this message translates to:
  /// **'State Variables'**
  String get stateVariables;

  /// No description provided for @stateVariablesN.
  ///
  /// In en, this message translates to:
  /// **'State Variables ({count})'**
  String stateVariablesN(num count);

  /// No description provided for @systemThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'System default theme uses your device\'s settings to determine when to use light or dark mode.'**
  String get systemThemeDescription;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Display name for a `ThemeMode`
  ///
  /// In en, this message translates to:
  /// **'{themeMode, select, light {Light} dark {Dark} system {System Default} other {Unknown}}'**
  String themeMode(String themeMode);

  /// No description provided for @thisWillClearAllMessages.
  ///
  /// In en, this message translates to:
  /// **'This will clear all network message history.'**
  String get thisWillClearAllMessages;

  /// No description provided for @traffic.
  ///
  /// In en, this message translates to:
  /// **'Traffic'**
  String get traffic;

  /// No description provided for @turnOnWifi.
  ///
  /// In en, this message translates to:
  /// **'Turn on Wi-Fi'**
  String get turnOnWifi;

  /// No description provided for @unableToLoadChangelog.
  ///
  /// In en, this message translates to:
  /// **'Unable to load changelog'**
  String get unableToLoadChangelog;

  /// No description provided for @unableToObtainInformation.
  ///
  /// In en, this message translates to:
  /// **'Unable to obtain service information'**
  String get unableToObtainInformation;

  /// No description provided for @unableToSubmitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Unable to submit feedback'**
  String get unableToSubmitFeedback;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// Display when a value is unknown
  ///
  /// In en, this message translates to:
  /// **'{name} unknown'**
  String unknownValue(String name);

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @viewInBrowser.
  ///
  /// In en, this message translates to:
  /// **'View in browser'**
  String get viewInBrowser;

  /// No description provided for @viewNetworkTraffic.
  ///
  /// In en, this message translates to:
  /// **'View network traffic'**
  String get viewNetworkTraffic;

  /// No description provided for @viewXml.
  ///
  /// In en, this message translates to:
  /// **'View XML'**
  String get viewXml;

  /// Display name for a `VisualDensity`
  ///
  /// In en, this message translates to:
  /// **'{visualDensity, select, comfortable {Comfortable} standard {Standard} compact {Compact} other {Unknown}}'**
  String visualDensity(String visualDensity);

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNew;

  /// No description provided for @wereOpenSource.
  ///
  /// In en, this message translates to:
  /// **'We\'re open source'**
  String get wereOpenSource;

  /// No description provided for @viewSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View this app\'s source code on GitHub'**
  String get viewSourceCode;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

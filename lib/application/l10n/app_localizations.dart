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

  /// No description provided for @viewContributors.
  ///
  /// In en, this message translates to:
  /// **'View Contributors'**
  String get viewContributors;

  /// No description provided for @contributors.
  ///
  /// In en, this message translates to:
  /// **'Contributors'**
  String get contributors;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @noActions.
  ///
  /// In en, this message translates to:
  /// **'No actions'**
  String get noActions;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// Actions
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @platformNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Platform not supported'**
  String get platformNotSupported;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @clearMessages.
  ///
  /// In en, this message translates to:
  /// **'Clear Messages?'**
  String get clearMessages;

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get discovery;

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

  /// No description provided for @deviceInformation.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get deviceInformation;

  /// No description provided for @fromAddress.
  ///
  /// In en, this message translates to:
  /// **'From {address}'**
  String fromAddress(String address);

  /// No description provided for @deviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Device Details'**
  String get deviceDetails;

  /// No description provided for @timestamp.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get timestamp;

  /// No description provided for @inputParameters.
  ///
  /// In en, this message translates to:
  /// **'Input Parameters'**
  String get inputParameters;

  /// No description provided for @requestHeaders.
  ///
  /// In en, this message translates to:
  /// **'Request Headers'**
  String get requestHeaders;

  /// No description provided for @responseHeaders.
  ///
  /// In en, this message translates to:
  /// **'Response Headers'**
  String get responseHeaders;

  /// No description provided for @payload.
  ///
  /// In en, this message translates to:
  /// **'Payload'**
  String get payload;

  /// No description provided for @timestampValue.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String timestampValue(DateTime time);

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

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @displaySettings.
  ///
  /// In en, this message translates to:
  /// **'Display Settings'**
  String get displaySettings;

  /// No description provided for @oledDark.
  ///
  /// In en, this message translates to:
  /// **'OLED Dark'**
  String get oledDark;

  /// No description provided for @oledDarkDescription.
  ///
  /// In en, this message translates to:
  /// **'Use a pure black background in dark mode to save power and increase contrast.'**
  String get oledDarkDescription;

  /// No description provided for @discoverySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delay, Hops'**
  String get discoverySubtitle;

  /// No description provided for @maxDelayDescription.
  ///
  /// In en, this message translates to:
  /// **'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.'**
  String get maxDelayDescription;

  /// No description provided for @maxResponseDelay.
  ///
  /// In en, this message translates to:
  /// **'Response Delay'**
  String get maxResponseDelay;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @responseBody.
  ///
  /// In en, this message translates to:
  /// **'Response Body'**
  String get responseBody;

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

  /// No description provided for @hops.
  ///
  /// In en, this message translates to:
  /// **'Hops (TTL)'**
  String get hops;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// No description provided for @multicastHopsDescription.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of network hops for multicast packages originating from this device.'**
  String get multicastHopsDescription;

  /// No description provided for @noDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No Devices Found.'**
  String get noDevicesFound;

  /// No description provided for @devicesUnavailableWhenNoNetwork.
  ///
  /// In en, this message translates to:
  /// **'UPnP devices are unavailable while disconnected from the network.'**
  String get devicesUnavailableWhenNoNetwork;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @rateOnGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Rate on Google Play'**
  String get rateOnGooglePlay;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @scanningForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for devices'**
  String get scanningForDevices;

  /// No description provided for @serialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serialNumber;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @autoRefresh.
  ///
  /// In en, this message translates to:
  /// **'Auto-refresh'**
  String get autoRefresh;

  /// No description provided for @autoRefreshDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically trigger a scan when opening the app.'**
  String get autoRefreshDescription;

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

  /// No description provided for @networkDisabled.
  ///
  /// In en, this message translates to:
  /// **'Network Disabled'**
  String get networkDisabled;

  /// No description provided for @checkNetworkSettings.
  ///
  /// In en, this message translates to:
  /// **'Please check your network settings'**
  String get checkNetworkSettings;

  /// No description provided for @openNetworkSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Network Settings'**
  String get openNetworkSettings;

  /// No description provided for @clearAllMessages.
  ///
  /// In en, this message translates to:
  /// **'Clear all messages'**
  String get clearAllMessages;

  /// No description provided for @keepMessages.
  ///
  /// In en, this message translates to:
  /// **'Keep Messages'**
  String get keepMessages;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @viewSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View Source Code'**
  String get viewSourceCode;

  /// No description provided for @viewChangelog.
  ///
  /// In en, this message translates to:
  /// **'View Changelog'**
  String get viewChangelog;

  /// No description provided for @unableToLoadChangelog.
  ///
  /// In en, this message translates to:
  /// **'Unable to load changelog'**
  String get unableToLoadChangelog;

  /// No description provided for @unableToSubmitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Unable to submit feedback'**
  String get unableToSubmitFeedback;

  /// No description provided for @submitABug.
  ///
  /// In en, this message translates to:
  /// **'Submit a Bug'**
  String get submitABug;

  /// No description provided for @filterByType.
  ///
  /// In en, this message translates to:
  /// **'filter by type'**
  String get filterByType;

  /// No description provided for @filterByIp.
  ///
  /// In en, this message translates to:
  /// **'Filter by IP'**
  String get filterByIp;

  /// No description provided for @invalidIpAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid IP address'**
  String get invalidIpAddress;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @statusMessage.
  ///
  /// In en, this message translates to:
  /// **'Status Message'**
  String get statusMessage;

  /// An HTTP status code and reason phrase
  ///
  /// In en, this message translates to:
  /// **'{code} {reason}'**
  String codeAndReason(int code, String reason);

  /// No description provided for @latency.
  ///
  /// In en, this message translates to:
  /// **'Latency'**
  String get latency;

  /// Display number of milliseconds elapsed
  ///
  /// In en, this message translates to:
  /// **'{count} ms'**
  String ms(num count);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @executeAction.
  ///
  /// In en, this message translates to:
  /// **'Execute Action'**
  String get executeAction;

  /// No description provided for @explorer.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get explorer;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @notExecuted.
  ///
  /// In en, this message translates to:
  /// **'Not Executed'**
  String get notExecuted;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note: '**
  String get note;

  /// No description provided for @discoverySettings.
  ///
  /// In en, this message translates to:
  /// **'Discovery Settings'**
  String get discoverySettings;

  /// No description provided for @discoverySettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune UPnP behavior when discovering devices.'**
  String get discoverySettingsDescription;

  /// No description provided for @protocolSettingsNote.
  ///
  /// In en, this message translates to:
  /// **'Changes to discovery settings will only take effect on the next scan. Aggressive settings may cause network congestion in some environments.'**
  String get protocolSettingsNote;

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

  /// No description provided for @msearchSent.
  ///
  /// In en, this message translates to:
  /// **'M-SEARCH Sent'**
  String get msearchSent;

  /// No description provided for @ssdpMulticastDiscovery.
  ///
  /// In en, this message translates to:
  /// **'SSDP Multicast Discovery'**
  String get ssdpMulticastDiscovery;

  /// No description provided for @notifyReceived.
  ///
  /// In en, this message translates to:
  /// **'NOTIFY Received'**
  String get notifyReceived;

  /// No description provided for @httpRequest.
  ///
  /// In en, this message translates to:
  /// **'{method} Request'**
  String httpRequest(Object method);

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNew;

  /// No description provided for @childDevices.
  ///
  /// In en, this message translates to:
  /// **'Child Devices'**
  String get childDevices;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @upnpServices.
  ///
  /// In en, this message translates to:
  /// **'UPnP Services'**
  String get upnpServices;

  /// No description provided for @toAddress.
  ///
  /// In en, this message translates to:
  /// **'To: {address}'**
  String toAddress(Object address);

  /// No description provided for @upnpDevices.
  ///
  /// In en, this message translates to:
  /// **'UPnP Devices'**
  String get upnpDevices;
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

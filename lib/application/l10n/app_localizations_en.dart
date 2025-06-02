// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get contributors => 'Contributors';

  @override
  String get aSpecialThanks => 'A special thanks!';

  @override
  String get filters => 'Filters';

  @override
  String get directionDescription => 'Direction';

  @override
  String get protocolDescription => 'Protocol';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get aboutThisDevice => 'About this device';

  @override
  String get from => 'From';

  @override
  String get noActionsForThisService => 'No actions for this service';

  @override
  String sendCommand(Object name) {
    return 'Send $name command';
  }

  @override
  String get to => 'To';

  @override
  String get about => 'About';

  @override
  String get type => 'Type';

  @override
  String get actions => 'Actions';

  @override
  String actionsN(num count) {
    return 'Actions ($count)';
  }

  @override
  String countVisible(num count) {
    return '$count visible';
  }

  @override
  String get adaptiveLayout => 'Adaptive layout';

  @override
  String get adaptiveLayoutDescription =>
      'Adapt the layout and color scheme of the app to the platform\'s operating system and dynamic color settings.';

  @override
  String get advancedMode => 'Advanced mode';

  @override
  String get advancedModeWarning =>
      'Advanced mode allows delays longer than recommended. Enabling advanced mode may have negative affects.';

  @override
  String get back => 'Back';

  @override
  String get changelog => 'Changelog';

  @override
  String changelogItem(String item) {
    return '- $item';
  }

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearHistory => 'Yes, clear history';

  @override
  String get clearMessages => 'Clear Messages?';

  @override
  String get close => 'Close';

  @override
  String commandFailedWithError(String error) {
    return 'Command failed $error';
  }

  @override
  String get controlUnavailable => 'Control Unavailable';

  @override
  String get copy => 'Copy';

  @override
  String get copyJson => 'Copy JSON';

  @override
  String get darkThemeDescription =>
      'Dark theme uses a black background to help keep your battery alive longer.';

  @override
  String get decrease => 'Decrease';

  @override
  String get decreaseDisabled => 'Decrease disabled';

  @override
  String get density => 'Visual density';

  @override
  String get devices => 'Devices';

  @override
  String devicesN(num count) {
    return 'Devices ($count)';
  }

  @override
  String direction(String direction) {
    String _temp0 = intl.Intl.selectLogic(
      direction,
      {
        'incoming': 'Received',
        'outgoing': 'Sent',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String discoveredDevice(String name) {
    return 'Discovered device $name';
  }

  @override
  String get discovery => 'Discovery';

  @override
  String get discoveryRequiresNetwork =>
      'Device discovery requires network access';

  @override
  String get display => 'Display';

  @override
  String get filter => 'Filter';

  @override
  String get foundBug => 'Found a bug?';

  @override
  String fromAddress(String address) {
    return 'From $address';
  }

  @override
  String get increase => 'Increase';

  @override
  String get increaseDisabled => 'Increase disabled';

  @override
  String get input => 'Input';

  @override
  String get keepHistory => 'No, keep history';

  @override
  String knownValue(String name, String value) {
    return '$name $value';
  }

  @override
  String get legalese =>
      'I take your privacy very seriously. Beyond the information Google provides to app developers, I use no third-party analytics or advertising frameworks. I log no information on you and have no interest in doing so.\n\nI do not collect, transmit, distribute, or sell your data.';

  @override
  String get letUsKnowHowWereDoing => 'Let us know how we\'re doing';

  @override
  String get licenses => 'Licenses';

  @override
  String get listSeparator => ', ';

  @override
  String mailBody(String version) {
    return 'Version $version';
  }

  @override
  String get mailSubject => 'App feedback';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get maxDelayDescription =>
      'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.';

  @override
  String get maxResponseDelay => 'Response delay';

  @override
  String messageLog(String direction, String time, String type) {
    String _temp0 = intl.Intl.selectLogic(
      direction,
      {
        'inn': 'received',
        'out': 'sent',
        'other': 'Unknown',
      },
    );
    return '$type $_temp0 at $time';
  }

  @override
  String get messages => 'Messages';

  @override
  String get modelDescription => 'Model Description';

  @override
  String get modelName => 'Model Name';

  @override
  String get modelNumber => 'Model Number';

  @override
  String get multicastHops => 'Multicast hops';

  @override
  String get multicastHopsDescription =>
      'Maximum number of network hops for multicast packages originating from this device.';

  @override
  String get neverAskAgain => 'Never ask again';

  @override
  String get noDevicesFound => 'No devices found.';

  @override
  String get nothingHere => 'There\'s nothing here.';

  @override
  String get notNow => 'Not now';

  @override
  String get off => 'Off';

  @override
  String get ok => 'OK';

  @override
  String get on => 'On';

  @override
  String get open => 'Open';

  @override
  String get openAnIssueOnOurGithub => 'Open an issue on our GitHub';

  @override
  String get openInBrowser => 'Open XML in browser';

  @override
  String get openPresentationInBrowser => 'Open presentation URL in browser';

  @override
  String get output => 'Output';

  @override
  String pleaseRateAppName(String appName) {
    return 'If you like $appName, or you\'ve found something we need to work on, we would love to hear about it. We would greatly appreciate it if you could rate the app on the Play Store. Thanks!';
  }

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String protocol(String protocol) {
    String _temp0 = intl.Intl.selectLogic(
      protocol,
      {
        'upnp': 'UPnP',
        'ssdp': 'SSDP',
        'soap': 'SOAP',
        'http': 'HTTP',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String rateAppName(String appName) {
    return 'Rate $appName';
  }

  @override
  String get rateOnGooglePlay => 'Rate on Google Play';

  @override
  String receivedAt(DateTime time) {
    final intl.DateFormat timeDateFormat =
        intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return 'Received at $timeString';
  }

  @override
  String get refresh => 'Refresh';

  @override
  String get request => 'Request';

  @override
  String get response => 'Response';

  @override
  String responseDelay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seconds',
      one: '1 second',
    );
    return '$_temp0';
  }

  @override
  String get scanningForDevices => 'Scanning for devices';

  @override
  String sentAt(DateTime time) {
    final intl.DateFormat timeDateFormat =
        intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return 'at $timeString';
  }

  @override
  String get serialNumber => 'Serial Number';

  @override
  String get serviceControlUnavailable =>
      'UPnP service control is unavailable at this time.';

  @override
  String get services => 'Services';

  @override
  String servicesN(num count) {
    return 'Services ($count)';
  }

  @override
  String get settings => 'Settings';

  @override
  String get stateVariables => 'State Variables';

  @override
  String stateVariablesN(num count) {
    return 'State Variables ($count)';
  }

  @override
  String get systemThemeDescription =>
      'System default theme uses your device\'s settings to determine when to use light or dark mode.';

  @override
  String get theme => 'Theme';

  @override
  String themeMode(String themeMode) {
    String _temp0 = intl.Intl.selectLogic(
      themeMode,
      {
        'light': 'Light',
        'dark': 'Dark',
        'system': 'System Default',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get thisWillClearAllMessages =>
      'This will clear all network message history.';

  @override
  String get traffic => 'Traffic';

  @override
  String get turnOnWifi => 'Turn on Wi-Fi';

  @override
  String get unableToLoadChangelog => 'Unable to load changelog';

  @override
  String get unableToObtainInformation =>
      'Unable to obtain service information';

  @override
  String get unableToSubmitFeedback => 'Unable to submit feedback';

  @override
  String get unavailable => 'Unavailable';

  @override
  String unknownValue(String name) {
    return '$name unknown';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get viewInBrowser => 'View in browser';

  @override
  String get viewNetworkTraffic => 'View network traffic';

  @override
  String get viewXml => 'View XML';

  @override
  String visualDensity(String visualDensity) {
    String _temp0 = intl.Intl.selectLogic(
      visualDensity,
      {
        'comfortable': 'Comfortable',
        'standard': 'Standard',
        'compact': 'Compact',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get wereOpenSource => 'We\'re open source';

  @override
  String get viewSourceCode => 'View this app\'s source code on GitHub';
}

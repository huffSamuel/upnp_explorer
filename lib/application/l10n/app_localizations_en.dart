// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get viewContributors => 'View Contributors';

  @override
  String get contributors => 'Contributors';

  @override
  String get filters => 'Filters';

  @override
  String get noActions => 'No actions';

  @override
  String get about => 'About';

  @override
  String get action => 'Action';

  @override
  String get actions => 'Actions';

  @override
  String get platformNotSupported => 'Platform not supported';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearMessages => 'Clear Messages?';

  @override
  String get discovery => 'Discovery';

  @override
  String get display => 'Display';

  @override
  String get filter => 'Filter';

  @override
  String get deviceInformation => 'Device Information';

  @override
  String fromAddress(String address) {
    return 'From $address';
  }

  @override
  String get deviceDetails => 'Device Details';

  @override
  String get timestamp => 'Timestamp';

  @override
  String get inputParameters => 'Input Parameters';

  @override
  String get requestHeaders => 'Request Headers';

  @override
  String get responseHeaders => 'Response Headers';

  @override
  String get payload => 'Payload';

  @override
  String timestampValue(DateTime time) {
    final intl.DateFormat timeDateFormat =
        intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String mailBody(String version) {
    return 'Version $version';
  }

  @override
  String get mailSubject => 'App feedback';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get seconds => 'Seconds';

  @override
  String get displaySettings => 'Display Settings';

  @override
  String get oledDark => 'OLED Dark';

  @override
  String get oledDarkDescription =>
      'Use a pure black background in dark mode to save power and increase contrast.';

  @override
  String get discoverySubtitle => 'Delay, Hops';

  @override
  String get maxDelayDescription =>
      'The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol.';

  @override
  String get maxResponseDelay => 'Response Delay';

  @override
  String get unknown => 'Unknown';

  @override
  String get responseBody => 'Response Body';

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
  String get hops => 'Hops (TTL)';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get multicastHopsDescription =>
      'Maximum number of network hops for multicast packages originating from this device.';

  @override
  String get noDevicesFound => 'No Devices Found.';

  @override
  String get devicesUnavailableWhenNoNetwork =>
      'UPnP devices are unavailable while disconnected from the network.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get rateOnGooglePlay => 'Rate on Google Play';

  @override
  String get refresh => 'Refresh';

  @override
  String get response => 'Response';

  @override
  String get scanningForDevices => 'Scanning for devices';

  @override
  String get serialNumber => 'Serial Number';

  @override
  String get settings => 'Settings';

  @override
  String get autoRefresh => 'Auto-refresh';

  @override
  String get autoRefreshDescription =>
      'Automatically trigger a scan when opening the app.';

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
  String get networkDisabled => 'Network Disabled';

  @override
  String get checkNetworkSettings => 'Please check your network settings';

  @override
  String get openNetworkSettings => 'Open Network Settings';

  @override
  String get clearAllMessages => 'Clear all messages';

  @override
  String get keepMessages => 'Keep Messages';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get resetFilters => 'Reset Filters';

  @override
  String get viewSourceCode => 'View Source Code';

  @override
  String get viewChangelog => 'View Changelog';

  @override
  String get unableToLoadChangelog => 'Unable to load changelog';

  @override
  String get unableToSubmitFeedback => 'Unable to submit feedback';

  @override
  String get submitABug => 'Submit a Bug';

  @override
  String get filterByType => 'filter by type';

  @override
  String get filterByIp => 'Filter by IP';

  @override
  String get invalidIpAddress => 'Invalid IP address';

  @override
  String get success => 'Success';

  @override
  String get failed => 'Failed';

  @override
  String get status => 'Status';

  @override
  String get statusMessage => 'Status Message';

  @override
  String codeAndReason(int code, String reason) {
    return '$code $reason';
  }

  @override
  String get latency => 'Latency';

  @override
  String ms(num count) {
    return '$count ms';
  }

  @override
  String get details => 'Details';

  @override
  String get serviceDetails => 'Service Details';

  @override
  String get executeAction => 'Execute Action';

  @override
  String get explorer => 'Explorer';

  @override
  String get method => 'Method';

  @override
  String get notExecuted => 'Not Executed';

  @override
  String get note => 'Note: ';

  @override
  String get discoverySettings => 'Discovery Settings';

  @override
  String get discoverySettingsDescription =>
      'Fine-tune UPnP behavior when discovering devices.';

  @override
  String get protocolSettingsNote =>
      'Changes to discovery settings will only take effect on the next scan. Aggressive settings may cause network congestion in some environments.';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get viewInBrowser => 'View in browser';

  @override
  String get msearchSent => 'M-SEARCH Sent';

  @override
  String get ssdpMulticastDiscovery => 'SSDP Multicast Discovery';

  @override
  String get notifyReceived => 'NOTIFY Received';

  @override
  String httpRequest(Object method) {
    return '$method Request';
  }

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get childDevices => 'Child Devices';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get upnpServices => 'UPnP Services';

  @override
  String toAddress(Object address) {
    return 'To: $address';
  }

  @override
  String get upnpDevices => 'UPnP Devices';
}

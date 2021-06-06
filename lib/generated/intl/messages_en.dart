// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(appName) => "About ${appName}";

  static m1(version) => "Version ${version}";

  static m2(seconds) => "${seconds} seconds";

  static m3(themeMode) => "${Intl.select(themeMode, {'light': 'Light', 'dark': 'Dark', 'system': 'System Defined', })}";

  static m4(version) => "Version ${version}";

  static m5(visualDensity) => "${Intl.select(visualDensity, {'comfortable': 'Comfortable', 'standard': 'Standard', 'compact': 'Compact', 'other': 'Unknown', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "aboutApp" : m0,
    "advancedMode" : MessageLookupByLibrary.simpleMessage("Advanced Mode"),
    "advancedModeDescription" : MessageLookupByLibrary.simpleMessage("Allow longer delay response"),
    "chooseTheme" : MessageLookupByLibrary.simpleMessage("Choose theme"),
    "density" : MessageLookupByLibrary.simpleMessage("Density"),
    "deviceDocument" : MessageLookupByLibrary.simpleMessage("Device Document"),
    "display" : MessageLookupByLibrary.simpleMessage("Display"),
    "featureOnlyAvailableInPro" : MessageLookupByLibrary.simpleMessage("This feature is only available in the Pro version."),
    "mailBody" : m1,
    "mailSubject" : MessageLookupByLibrary.simpleMessage("App Feedback"),
    "maxDelayDescription" : MessageLookupByLibrary.simpleMessage("The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol."),
    "maxResponseDelay" : MessageLookupByLibrary.simpleMessage("Maximum Response Delay"),
    "multicastHops" : MessageLookupByLibrary.simpleMessage("Multicast Hops"),
    "multicastHopsDescription" : MessageLookupByLibrary.simpleMessage("The maximum network hops for multicast packages originating from this device."),
    "na" : MessageLookupByLibrary.simpleMessage("N/A"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onlyAvailableInPro" : MessageLookupByLibrary.simpleMessage("Available in Pro"),
    "response" : MessageLookupByLibrary.simpleMessage("Response"),
    "responseDelay" : m2,
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "ssdpProtocol" : MessageLookupByLibrary.simpleMessage("SSDP Protocol"),
    "submitBug" : MessageLookupByLibrary.simpleMessage("Submit Bug"),
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "themeMode" : m3,
    "unableToSubmitFeedback" : MessageLookupByLibrary.simpleMessage("Unable to submit feedback"),
    "version" : m4,
    "viewFormatted" : MessageLookupByLibrary.simpleMessage("View Formatted"),
    "viewInStore" : MessageLookupByLibrary.simpleMessage("View in store"),
    "viewRaw" : MessageLookupByLibrary.simpleMessage("View Raw"),
    "visualDensity" : m5
  };
}

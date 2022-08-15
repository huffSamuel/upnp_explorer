// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(appName) => "About ${appName}";

  static String m1(count) => "Actions ${count}";

  static String m2(count) => "Devices ${count}";

  static String m3(name) => "Discovered device ${name}";

  static String m4(version) => "Version ${version}";

  static String m5(seconds) => "${seconds} seconds";

  static String m6(count) => "Services ${count}";

  static String m7(count) => "State Variables ${count}";

  static String m8(themeMode) => "${Intl.select(themeMode, {
            'light': 'Light',
            'dark': 'Dark',
            'system': 'System Defined',
          })}";

  static String m9(version) => "Version ${version}";

  static String m10(visualDensity) => "${Intl.select(visualDensity, {
            'comfortable': 'Comfortable',
            'standard': 'Standard',
            'compact': 'Compact',
            'other': 'Unknown',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "aboutApp": m0,
        "actions": MessageLookupByLibrary.simpleMessage("Actions"),
        "actionsN": m1,
        "advancedMode": MessageLookupByLibrary.simpleMessage("Advanced Mode"),
        "advancedModeDescription":
            MessageLookupByLibrary.simpleMessage("Allow longer delay response"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Choose theme"),
        "controlUnavailable":
            MessageLookupByLibrary.simpleMessage("Control Unavailable"),
        "decrease": MessageLookupByLibrary.simpleMessage("Decrease"),
        "decreaseDisabled":
            MessageLookupByLibrary.simpleMessage("Decrease disabled"),
        "density": MessageLookupByLibrary.simpleMessage("Density"),
        "devices": MessageLookupByLibrary.simpleMessage("Devices"),
        "devicesN": m2,
        "discoveredDevice": m3,
        "discoveryRequiresNetwork": MessageLookupByLibrary.simpleMessage(
            "Device discovery requires network access"),
        "display": MessageLookupByLibrary.simpleMessage("Display"),
        "increase": MessageLookupByLibrary.simpleMessage("Increase"),
        "increaseDisabled":
            MessageLookupByLibrary.simpleMessage("Increase disabled"),
        "legalese": MessageLookupByLibrary.simpleMessage(
            "I take your privacy very seriously. Beyond the information Google provides to app developers, I use no third-party analytics or advertising frameworks. I log no information on you and have no interest in doing so.\n\nI do not collect, transmit, distribute, or sell your data."),
        "listSeparator": MessageLookupByLibrary.simpleMessage(", "),
        "mailBody": m4,
        "mailSubject": MessageLookupByLibrary.simpleMessage("App Feedback"),
        "manufacturer": MessageLookupByLibrary.simpleMessage("Manufacturer"),
        "maxDelayDescription": MessageLookupByLibrary.simpleMessage(
            "The maximum delay time in seconds that a device can take before responding. This is an attempt to overcome a scaling issue implicit with SSDP.\n\nThe value should be between 1 and 5. Longer delays can result in issues with the SSDP protocol."),
        "maxResponseDelay":
            MessageLookupByLibrary.simpleMessage("Maximum Response Delay"),
        "modelDescription":
            MessageLookupByLibrary.simpleMessage("Model Description"),
        "modelName": MessageLookupByLibrary.simpleMessage("Model Name"),
        "modelNumber": MessageLookupByLibrary.simpleMessage("Model Number"),
        "multicastHops": MessageLookupByLibrary.simpleMessage("Multicast Hops"),
        "multicastHopsDescription": MessageLookupByLibrary.simpleMessage(
            "The maximum network hops for multicast packages originating from this device."),
        "noDevicesFound":
            MessageLookupByLibrary.simpleMessage("No devices found."),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "openInBrowser":
            MessageLookupByLibrary.simpleMessage("Open in browser"),
        "openPresentationInBrowser": MessageLookupByLibrary.simpleMessage(
            "Open presentation URL in browser"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "responseDelay": m5,
        "scanningForDevices":
            MessageLookupByLibrary.simpleMessage("Scanning for devices"),
        "serialNumber": MessageLookupByLibrary.simpleMessage("Serial Number"),
        "serviceControlUnavailable": MessageLookupByLibrary.simpleMessage(
            "UPnP service control is unavailable at this time."),
        "services": MessageLookupByLibrary.simpleMessage("Services"),
        "servicesN": m6,
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "ssdpProtocol": MessageLookupByLibrary.simpleMessage("SSDP Protocol"),
        "stateVariables":
            MessageLookupByLibrary.simpleMessage("State Variables"),
        "stateVariablesN": m7,
        "submitBug": MessageLookupByLibrary.simpleMessage("Submit Bug"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "themeMode": m8,
        "turnOnWifi": MessageLookupByLibrary.simpleMessage("Turn on WiFi"),
        "unableToObtainInformation": MessageLookupByLibrary.simpleMessage(
            "Unable to obtain service information"),
        "unableToSubmitFeedback":
            MessageLookupByLibrary.simpleMessage("Unable to submit feedback"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
        "version": m9,
        "visualDensity": m10
      };
}
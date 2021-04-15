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

  static m1(themeMode) => "${Intl.select(themeMode, {'light': 'Light', 'dark': 'Dark', 'system': 'System Defined', })}";

  static m2(version) => "Version ${version}";

  static m3(visualDensity) => "${Intl.select(visualDensity, {'comfortable': 'Comfortable', 'standard': 'Standard', 'compact': 'Compact', 'other': 'Unknown', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "aboutApp" : m0,
    "chooseTheme" : MessageLookupByLibrary.simpleMessage("Choose theme"),
    "density" : MessageLookupByLibrary.simpleMessage("Density"),
    "deviceDescription" : MessageLookupByLibrary.simpleMessage("Device Description"),
    "deviceDocument" : MessageLookupByLibrary.simpleMessage("Device Document"),
    "display" : MessageLookupByLibrary.simpleMessage("Display"),
    "maxWaitResponseTime" : MessageLookupByLibrary.simpleMessage("Max Wait Response Time"),
    "multicastHops" : MessageLookupByLibrary.simpleMessage("Multicast Hops"),
    "na" : MessageLookupByLibrary.simpleMessage("N/A"),
    "response" : MessageLookupByLibrary.simpleMessage("Response"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "ssdpProtocol" : MessageLookupByLibrary.simpleMessage("SSDP Protocol"),
    "submitBug" : MessageLookupByLibrary.simpleMessage("Submit Bug"),
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "themeMode" : m1,
    "version" : m2,
    "viewFormatted" : MessageLookupByLibrary.simpleMessage("View Formatted"),
    "viewRaw" : MessageLookupByLibrary.simpleMessage("View Raw"),
    "visualDensity" : m3
  };
}

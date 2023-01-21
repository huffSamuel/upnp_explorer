import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Stream<LicenseEntry> licenseEntries() async* {
  final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  final animatedListLicense =
      await rootBundle.loadString('assets/automatic_animated_list/license.txt');
  yield LicenseEntryWithLineBreaks(
      ['automatic_animated_list'], animatedListLicense);
}

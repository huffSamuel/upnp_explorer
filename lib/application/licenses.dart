import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void registerLicenses() {
  LicenseRegistry.addLicense(_licenseEntries);
}

Stream<LicenseEntry> _licenseEntries() async* {
  final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['google_fonts'], license);
}

import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import 'application.dart';

@lazySingleton
class BugReportService {
  void submitBug(String subject, String body, Function() onCannotSubmit) async {
    if (await canLaunchUrl(Application.submitBugUri)) {
      launchUrl(Application.submitBugUri);
    } else {
      onCannotSubmit();
    }
  }
}

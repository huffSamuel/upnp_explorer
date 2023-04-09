import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/application.dart';

@lazySingleton
class BugReportService {
  void submitBug(String subject, String body, Function() onCannotSubmit) async {
    if (await canLaunchUrl(Uri.parse(Application.submitBugUrl))) {
      launchUrl(Uri.parse(Application.submitBugUrl));
    } else {
      onCannotSubmit();
    }
  }
}

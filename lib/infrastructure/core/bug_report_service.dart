import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/application.dart';

@Singleton()
class BugReportService {
  void submitBug(String subject, String body, Function() onCannotSubmit) async {
    if (await canLaunch(Application.submitBugUrl)) {
      launch(Application.submitBugUrl);
    } else {
      onCannotSubmit();
    }
  }
}

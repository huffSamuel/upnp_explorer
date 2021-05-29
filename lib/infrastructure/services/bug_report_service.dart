import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';

class BugReportService {
  void submitBug(String subject, String body, Function() onCannotSubmit) async {
    final mailto = Uri(
      scheme: 'mailto',
      path: kSubmitBugEmail,
      query: sprintf(kSubmitBugQuery, [subject, body]),
    ).toString();

    if (await canLaunch(kSubmitBugUrl)) {
      launch(kSubmitBugUrl);
    } else if (await canLaunch(mailto)) {
      launch(mailto.toString());
    } else {
      onCannotSubmit();
    }
  }
}

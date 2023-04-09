import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../application.dart';

const _launchedDateKey = 'review_launchedDate';
const _neverAskAgainKey = 'review_neverAskAgain';

@lazySingleton
class ReviewService {
  final _days = 7;
  final _inAppReview = InAppReview.instance;
  final SharedPreferences _prefs;

  ReviewService(this._prefs);

  Future<void> neverAskAgain() {
    return _prefs.setBool(_neverAskAgainKey, true);
  }

  Future<bool> isAvailable() async {
    final launchedDateString = _prefs.getString(_launchedDateKey);

    if (launchedDateString == null) {
      await _prefs.setString(
          _launchedDateKey, DateTime.now().toIso8601String());
      return false;
    }

    final launchedDate = DateTime.parse(launchedDateString);

    if (launchedDate.difference(DateTime.now()).inDays < _days) {
      return false;
    }

    final neverAskAgain = _prefs.getBool(_neverAskAgainKey);

    if (neverAskAgain == true) {
      return false;
    }

    return _inAppReview.isAvailable();
  }

  Future<void> launchInAppReview() {
    return _prefs
        .setBool(_neverAskAgainKey, true)
        .then((_) => _inAppReview.requestReview());
  }

  Future<void> launchStorePage() {
    return _inAppReview.openStoreListing(appStoreId: Application.appId);
  }
}

enum ReviewResponse { notNow, never, ok }

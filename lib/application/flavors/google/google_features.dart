import 'package:in_app_review/in_app_review.dart';

import '../../application.dart';
import '../flavor_features.dart';

class GoogleFeatures extends FlavorFeatures {
  @override
  Future<void> openStoreListing() =>
      InAppReview.instance.openStoreListing(appStoreId: Application.appId);

  @override
  bool get showRatingTile => true;
}

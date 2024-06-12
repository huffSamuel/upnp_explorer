import 'package:in_app_review/in_app_review.dart';
import 'package:upnp_explorer/application/application.dart';
import 'package:upnp_explorer/application/flavors/flavor_features.dart';

class GoogleFeatures extends FlavorFeatures {
  @override
  Future<void> openStoreListing() => InAppReview.instance.openStoreListing(appStoreId: Application.appId);
  
  @override
  bool get showRatingTile => true;

}
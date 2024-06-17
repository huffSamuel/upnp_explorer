import 'package:upnp_explorer/application/flavors/flavor_features.dart';

class FossFeatures extends FlavorFeatures {
  @override
  Future<void> openStoreListing() => Future.value();

  @override
  bool get showRatingTile => false;
}

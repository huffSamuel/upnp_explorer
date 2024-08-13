import 'package:upnp_explorer/application/flavors/flavor_features.dart';

class DefaultFeatures extends FlavorFeatures {
  @override
  Future<void> openStoreListing() {
    throw UnimplementedError();
  }

  @override
  bool get showRatingTile => false;
}

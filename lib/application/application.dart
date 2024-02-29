class Application {
  static const repoUrl = 'https://github.com/huffSamuel/upnp_explorer';
  static const submitBugUrl = '${repoUrl}/issues/new/choose';
  static const name = 'UPnP Explorer';
  static const privacyPolicyUrl = '${repoUrl}/blob/main/PRIVACY_POLICY.md';
  static const appId = 'com.samueljhuf.upnp_explorer';

  static const assets = const Assets();
}

class Assets {
  String get contributors => _path('CONTRIBUTORS.json');

  _path(String filename) {
    return 'assets/$filename';
  }

  const Assets();
}

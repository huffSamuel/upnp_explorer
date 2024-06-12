class Application {
  static const repoUrl = 'https://github.com/huffSamuel/upnp_explorer';
  static const _blob = '$repoUrl/blob/main';
  static const submitBugUrl = '${repoUrl}/issues/new/choose';
  static const name = 'UPnP Explorer';
  static const privacyPolicyUrl = '$_blob/PRIVACY_POLICY.md';
  static const changelogUrl = '$_blob/CHANGELOG.md';
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

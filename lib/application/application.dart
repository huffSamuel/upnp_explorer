class GitHub {
  static const baseApiUrl = 'https://api.github.com';
  static const baseContentUrl = 'https://raw.githubusercontent.com';
  static const baseWebUrl = 'http://github.com';
}

class Application {
  static const _username = 'huffSamuel';
  static const _repo = 'upnp_explorer';
  
  static const _repoUrl = '${GitHub.baseWebUrl}/$_username/$_repo';
  static const _blob = '$_repoUrl/blob/main';

  static const name = 'UPnP Explorer';
  static const appId = 'com.samueljhuf.upnp_explorer';

  static final repoUri = Uri.parse(_repoUrl);
  static final changelogUri = Uri.parse('$_blob/CHANGELOG.md');
  static final submitBugUri = Uri.parse('$_repoUrl/issues/new/choose');
  static final privacyPolicyUri = Uri.parse('$_blob/PRIVACY_POLICY.md');

  static final contributorUri = Uri.parse(
      '${GitHub.baseApiUrl}/repos/$_username/$_repo/contributors');

  static const assets = const Assets();
}

class Assets {
  String get contributors => _path('CONTRIBUTORS.json');

  _path(String filename) {
    return 'assets/$filename';
  }

  const Assets();
}

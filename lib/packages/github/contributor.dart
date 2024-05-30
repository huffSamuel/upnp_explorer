/// A github user who has contributed to a repository.
class Contributor {
  /// The login name of the contributor
  final String login;

  /// The URL to the user's avatar.
  final String avatarUrl;

  /// The URL to the user's github profile.
  final String profileUrl;

  /// The user type.
  final UserType? type;

  Contributor({
    required this.login,
    required this.avatarUrl,
    required this.profileUrl,
    required this.type,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    UserType type = UserType.unknown;

    switch (json['type']) {
      case 'User':
        type = UserType.user;
        break;
      case 'Bot':
        type = UserType.bot;
        break;
    }

    return Contributor(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      profileUrl: json['html_url'],
      type: type,
    );
  }
}

enum UserType { unknown, user, bot }

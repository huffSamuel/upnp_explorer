class Contributor {
  final String login;
  final String avatarUrl;
  final String profileUrl;
  final UserType? type;

  Contributor({
    required this.login,
    required this.avatarUrl,
    required this.profileUrl,
    required this.type,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    UserType type = UserType.unknown;
    print(json['type']);
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

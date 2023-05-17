class Account {
  final String id;
  final String acct;
  final String avatar;
  final String displayName;
  final String username;

  Account({
    required this.id,
    required this.acct,
    required this.avatar,
    required this.displayName,
    required this.username,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      acct: json['acct'],
      avatar: json['avatar'],
      displayName: json['display_name'],
      username: json['username'],
    );
  }
}

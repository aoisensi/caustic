class Status {
  final String id;
  final String accountId;
  final String content;
  final String uri;

  Status({
    required this.id,
    required this.accountId,
    required this.content,
    required this.uri,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      accountId: json['account']['id'],
      content: json['content'],
      uri: json['uri'],
    );
  }
}

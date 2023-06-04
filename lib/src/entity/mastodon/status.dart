import 'emoji.dart';

class Status {
  final String id;
  final String accountId;
  final String content;
  final String uri;
  final String? reblogId;
  final bool favourited;
  final bool reblogged;
  final DateTime createdAt;
  final List<Emoji> emojis;

  Status({
    required this.id,
    required this.accountId,
    required this.content,
    required this.uri,
    required this.reblogId,
    required this.favourited,
    required this.reblogged,
    required this.createdAt,
    required this.emojis,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      accountId: json['account']['id'],
      content: json['content'],
      uri: json['uri'],
      reblogId: json['reblog']?['id'],
      favourited: json['favourited'] ?? false,
      reblogged: json['reblogged'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      emojis: (json['emojis'] as List<dynamic>)
          .map((e) => Emoji.fromJson(e))
          .toList(),
    );
  }
}

import 'dart:convert';

import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../notifier/mastodon/account_notifier.dart';

final mastodonAccessTokenProvider =
    Provider((ref) => "5r1PZkvDiDjq9-zBvefjG2snU7-jtTTHCT7KaDeENy8");
final mastodonDomainProvider = Provider((ref) => "social.vivaldi.net");

class MastodonRepository {
  MastodonRepository(this._ref);
  final Ref _ref;

  Future<List<String>> getPublicTimeline() async {
    final response = await _get('/api/v1/timelines/public');
    final json = _decode(response);
    return MastodonStatusNotifier.cacheList(_ref, json);
  }

  Future<String> getAccount({required String id}) async {
    final response = await _get('/api/v1/accounts/$id');
    final json = _decode(response);
    return MastodonAccountNotifier.cache(_ref, json);
  }

  Future<String> getStatus({required String id}) async {
    final response = await _get('/api/v1/statuses/$id');
    final json = _decode(response);
    return MastodonStatusNotifier.cache(_ref, json);
  }

  Future<http.Response> _get(String path, {Map<String, dynamic>? params}) {
    final uri = Uri.https(_domain, path, params);
    return http.get(uri, headers: {'Authorization': 'Bearer $_token'});
  }

  dynamic _decode(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load post');
    }
  }

  String get _token => _ref.read(mastodonAccessTokenProvider);
  String get _domain => _ref.read(mastodonDomainProvider);
}

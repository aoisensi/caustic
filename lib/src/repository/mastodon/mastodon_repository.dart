import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final mastodonAccessTokenProvider =
    Provider((ref) => dotenv.env['ALPHA_TOKEN']!);
final mastodonDomainProvider = Provider((ref) => "social.vivaldi.net");

class MastodonRepository {
  MastodonRepository(this._ref);
  final Ref _ref;

  Future<List<dynamic>> getPublicTimeline() async {
    final response = await _get('/api/v1/timelines/public');
    return _decode(response);
  }

  Future<List<dynamic>> getHomeTimeline() async {
    final response = await _get('/api/v1/timelines/home');
    return _decode(response);
  }

  Future<dynamic> getAccount({required String id}) async {
    final response = await _get('/api/v1/accounts/$id');
    return _decode(response);
  }

  Future<dynamic> getStatus({required String id}) async {
    final response = await _get('/api/v1/statuses/$id');
    return _decode(response);
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

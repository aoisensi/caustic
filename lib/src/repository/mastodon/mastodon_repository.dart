import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final mastodonAccessTokenProvider =
    Provider((ref) => dotenv.env['ALPHA_TOKEN']!);
final mastodonDomainProvider = Provider((ref) => "social.vivaldi.net");
final mastodonRepositoryProvider = Provider(
  (ref) {
    final token = ref.read(mastodonAccessTokenProvider);
    final domain = ref.read(mastodonDomainProvider);
    return MastodonRepository(domain, token);
  },
  dependencies: [mastodonAccessTokenProvider, mastodonDomainProvider],
);

class MastodonRepository {
  MastodonRepository(this._domain, this._token);
  final String _domain;
  final String _token;

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

  Future<dynamic> postStatusFavourite({required String id}) async {
    final response = await _post('/api/v1/statuses/$id/favourite');
    return _decode(response);
  }

  Future<dynamic> postStatusUnfavourite({required String id}) async {
    final response = await _post('/api/v1/statuses/$id/unfavourite');
    return _decode(response);
  }

  Future<dynamic> postStatusReblog({required String id}) async {
    final response = await _post('/api/v1/statuses/$id/reblog');
    return _decode(response);
  }

  Future<dynamic> postStatusUnreblog({required String id}) async {
    final response = await _post('/api/v1/statuses/$id/unreblog');
    return _decode(response);
  }

  Future<http.Response> _get(String path, {Map<String, dynamic>? params}) {
    final uri = _uri(path, params: params);
    return http.get(uri, headers: {'Authorization': 'Bearer $_token'});
  }

  Future<http.Response> _post(String path, {Map<String, dynamic>? params}) {
    final uri = _uri(path, params: params);
    return http.post(uri, headers: {'Authorization': 'Bearer $_token'});
  }

  dynamic _decode(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Uri _uri(String path, {Map<String, dynamic>? params}) =>
      Uri.https(_domain, path, params);
}

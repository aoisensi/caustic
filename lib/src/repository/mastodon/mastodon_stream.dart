import 'dart:convert';

import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:caustic/src/notifier/mastodon/timeline_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'mastodon_repository.dart';

final mastodonStreamProvider = StreamProvider(
  (ref) async* {
    final token = ref.read(mastodonAccessTokenProvider);
    final domain = ref.read(mastodonDomainProvider);
    final uri = Uri(
      scheme: 'wss',
      host: domain,
      path: '/api/v1/streaming',
      queryParameters: {
        'access_token': token,
      },
    );
    final ws = WebSocketChannel.connect(uri);
    ws.sink.add('{"type": "subscribe", "stream": "user"}');
    ws.sink.add('{"type": "subscribe", "stream": "public"}');
    ref.onDispose(ws.sink.close);
    await for (final json in ws.stream) {
      final data = jsonDecode(json);
      final payload = jsonDecode(data['payload']);
      switch (data['event']) {
        case 'update':
          final id = MastodonStatusNotifier.cache(ref, payload);
          for (final stream in data['stream']) {
            final provider = _timelineProviders[stream];
            if (provider == null) continue;
            ref.read(provider.notifier).addToLatest(id);
          }
      }
      yield null;
    }
  },
  dependencies: [mastodonAccessTokenProvider, mastodonDomainProvider],
);

final _timelineProviders = {
  'public': mastodonPublicTimelineProvider,
  'user': mastodonHomeTimelineProvider,
};

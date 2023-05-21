import 'dart:async';

import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:caustic/src/repository/mastodon/mastodon_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mastodonPublicTimelineProvider =
    AsyncNotifierProvider<MastodonPublicTimelineNotifier, List<String>>(
        MastodonPublicTimelineNotifier.new);
final mastodonHomeTimelineProvider =
    AsyncNotifierProvider<MastodonHomeTimelineNotifier, List<String>>(
        MastodonHomeTimelineNotifier.new);

class MastodonPublicTimelineNotifier extends MastodonTimelineNotifierBase {
  @override
  Future<List<String>> getter(MastodonRepository mastodon) async {
    final json = await mastodon.getPublicTimeline();
    return MastodonStatusNotifier.cacheList(ref, json);
  }
}

class MastodonHomeTimelineNotifier extends MastodonTimelineNotifierBase {
  @override
  Future<List<String>> getter(MastodonRepository mastodon) async {
    final json = await mastodon.getHomeTimeline();
    return MastodonStatusNotifier.cacheList(ref, json);
  }
}

abstract class MastodonTimelineNotifierBase
    extends AsyncNotifier<List<String>> {
  Future<List<String>> getter(MastodonRepository mastodon);

  @override
  FutureOr<List<String>> build() {
    return getter(ref.read(mastodonRepositoryProvider));
  }

  void addToLatest(String id) {
    state = AsyncValue.data([id, ...(state.value ?? [])]);
  }
}

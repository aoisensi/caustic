import 'dart:async';

import 'package:caustic/src/repository/mastodon/mastodon_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mastodonTimelineProvider =
    AsyncNotifierProvider<MastodonTimelineNotifier, List<String>>(
        MastodonTimelineNotifier.new);

class MastodonTimelineNotifier extends AsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() {
    return MastodonRepository(ref).getPublicTimeline();
  }
}

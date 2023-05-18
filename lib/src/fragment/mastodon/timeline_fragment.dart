import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifier/mastodon/timeline_notifier.dart';
import '../../view/mastodon/timeline_status_view.dart';

class MastodonHomeTimelineFragment extends MastodonTimelineFragmentBase {
  const MastodonHomeTimelineFragment({super.key});

  @override
  AsyncValue<List<String>> getTimeline(WidgetRef ref) {
    return ref.watch(mastodonHomeTimelineProvider);
  }
}

class MastodonPublicTimelineFragment extends MastodonTimelineFragmentBase {
  const MastodonPublicTimelineFragment({super.key});

  @override
  AsyncValue<List<String>> getTimeline(WidgetRef ref) {
    return ref.watch(mastodonPublicTimelineProvider);
  }
}

abstract class MastodonTimelineFragmentBase extends ConsumerWidget {
  const MastodonTimelineFragmentBase({super.key});

  AsyncValue<List<String>> getTimeline(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = getTimeline(ref);
    return timeline.when(
      data: (timeline) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final statusId = timeline[index];
            return TimelineStatusView(statusId);
          },
          itemCount: timeline.length,
        );
      },
      error: (error, _) => const Center(child: Text('Error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

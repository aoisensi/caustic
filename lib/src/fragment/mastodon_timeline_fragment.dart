import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/mastodon/account_notifier.dart';
import '../notifier/mastodon/timeline_notifier.dart';

class MastodonTimelineFragment extends ConsumerWidget {
  const MastodonTimelineFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(mastodonTimelineProvider);
    return timeline.when(
      data: (timeline) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final status =
                ref.watch(mastodonStatusProvider(timeline[index])).value!;
            final account =
                ref.watch(mastodonAccountProvider(status.accountId)).value!;
            return Card(
              child: ListTile(
                leading: Image.network(account.avatar),
                title: Html(data: status.content),
              ),
            );
          },
          itemCount: timeline.length,
        );
      },
      error: (error, _) => const Center(child: Text('Error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

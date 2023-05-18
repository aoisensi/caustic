import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifier/mastodon/account_notifier.dart';

class TimelineStatusView extends ConsumerWidget {
  const TimelineStatusView(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(mastodonStatusProvider(id)).value!;
    final account = ref.watch(mastodonAccountProvider(status.accountId)).value!;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(account.avatar),
                ),
                Text(account.displayName),
              ],
            ),
            Html(data: status.content),
          ],
        ),
      ),
    );
  }
}

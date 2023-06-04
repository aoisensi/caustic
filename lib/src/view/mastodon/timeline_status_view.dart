import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:caustic/src/view/mastodon/avatar_view.dart';
import 'package:caustic/src/view/mastodon/status_content_view.dart';
import 'package:caustic/src/view/relative_timer_view.dart';
import 'package:flutter/material.dart';
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
      child: Column(
        children: [
          ListTile(
            leading: AvatarView(url: account.avatar),
            title: Text(
              account.displayName,
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    '@${account.acct}',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                RelativeTimerView(status.createdAt),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StatusContentView(status: status),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.repeat),
                onPressed: () {
                  status.reblogged
                      ? ref.read(mastodonStatusProvider(id).notifier).unreblog()
                      : ref.read(mastodonStatusProvider(id).notifier).reblog();
                },
                color: status.reblogged ? Colors.green : null,
              ),
              IconButton(
                icon: const Icon(Icons.star),
                color: status.favourited ? Colors.yellow : null,
                onPressed: () {
                  status.favourited
                      ? ref
                          .read(mastodonStatusProvider(id).notifier)
                          .unfavourite()
                      : ref
                          .read(mastodonStatusProvider(id).notifier)
                          .favourite();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

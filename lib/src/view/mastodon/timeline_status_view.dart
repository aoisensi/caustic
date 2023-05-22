import 'package:caustic/src/notifier/mastodon/status_notifier.dart';
import 'package:caustic/src/view/mastodon/avatar_view.dart';
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
      child: Column(
        children: [
          ListTile(
            leading: AvatarView(url: account.avatar),
            title: Text(account.displayName),
            subtitle: Text('@${account.acct}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Html(data: status.content),
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

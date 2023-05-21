import 'package:caustic/src/activity/desktop_home_activity.dart';
import 'package:caustic/src/repository/mastodon/mastodon_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mastodonStreamProvider);
    return const MaterialApp(
      home: DesktopHomeActivity(),
    );
  }
}

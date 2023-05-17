import 'package:caustic/src/fragment/mastodon_timeline_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeActivity extends ConsumerWidget {
  const HomeActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caustic'),
      ),
      body: const MastodonTimelineFragment(),
    );
  }
}

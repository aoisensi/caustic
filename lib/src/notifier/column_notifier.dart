import 'package:caustic/src/fragment/mastodon/timeline_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final columnProvider =
    NotifierProvider<ColumnNotifier, List<ColumnData>>(ColumnNotifier.new);

class ColumnData {
  const ColumnData(this.fragment, this.title);

  final Widget fragment;
  final String title;
}

class ColumnNotifier extends Notifier<List<ColumnData>> {
  @override
  List<ColumnData> build() {
    return const [
      ColumnData(
        MastodonHomeTimelineFragment(),
        'Home',
      ),
      ColumnData(
        MastodonPublicTimelineFragment(),
        'Public',
      ),
    ];
  }
}

import 'package:caustic/src/notifier/column_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fragment/column_fragment.dart';

class DesktopHomeActivity extends ConsumerWidget {
  const DesktopHomeActivity({super.key});

  static const _space = 4.0; // material ok

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final columns = ref.watch(columnProvider).map((data) {
      return SizedBox(
        width: 360,
        child: ColumnFragment(data.fragment, data.title),
      );
    }).toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _space),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: columns.length,
          itemBuilder: (context, index) => columns[index],
          separatorBuilder: (context, index) => const SizedBox(width: _space),
        ),
      ),
    );
  }
}

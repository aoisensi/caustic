import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTimeProvider = StreamProvider((ref) async* {
  while (true) {
    yield DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
  }
});

class RelativeTimerView extends ConsumerWidget {
  const RelativeTimerView(this.time, {super.key});

  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(currentTimeProvider).value;
    if (now == null) {
      return Container();
    }
    final diff = now.difference(time);
    return Text(
      _text(diff),
      maxLines: 1,
    );
  }

  String _text(Duration diff) {
    if (diff.inDays > 0) {
      return '${diff.inDays}d';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds}s';
    } else {
      return 'now';
    }
  }
}

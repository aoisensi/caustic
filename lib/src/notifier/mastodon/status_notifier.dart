import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/mastodon/status.dart';
import '../../repository/mastodon/mastodon_repository.dart';
import 'account_notifier.dart';

final mastodonStatusProvider =
    NotifierProvider.family<MastodonStatusNotifier, AsyncValue<Status>, String>(
        MastodonStatusNotifier.new);

class MastodonStatusNotifier
    extends FamilyNotifier<AsyncValue<Status>, String> {
  late final String id;

  @override
  AsyncValue<Status> build(String arg) {
    id = arg;
    return const AsyncValue.loading();
  }

  Future<void> fetch() async {
    try {
      await ref.read(mastodonRepositoryProvider).getStatus(id: id);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  static String cache(Ref ref, dynamic json) {
    final status = Status.fromJson(json);
    ref.read(mastodonStatusProvider(status.id).notifier).state =
        AsyncValue.data(status);
    MastodonAccountNotifier.cache(ref, json['account']);
    return status.id;
  }

  static List<String> cacheList(Ref ref, List<dynamic> json) {
    return json.map((json) => cache(ref, json)).toList();
  }
}

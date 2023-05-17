import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/mastodon/account.dart';
import '../../repository/mastodon/mastodon_repository.dart';

final mastodonAccountProvider = NotifierProvider.family<MastodonAccountNotifier,
    AsyncValue<Account>, String>(MastodonAccountNotifier.new);

class MastodonAccountNotifier
    extends FamilyNotifier<AsyncValue<Account>, String> {
  late final String id;

  @override
  AsyncValue<Account> build(String arg) {
    id = arg;
    return const AsyncValue.loading();
  }

  Future<void> fetch() async {
    try {
      await MastodonRepository(ref).getAccount(id: id);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  static String cache(Ref ref, dynamic json) {
    final account = Account.fromJson(json);
    ref.read(mastodonAccountProvider(account.id).notifier).state =
        AsyncValue.data(account);
    return account.id;
  }
}

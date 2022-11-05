import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/usecase/util/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ethereum_connector.vm.dart';

final messagesProviders = StateNotifierProvider.family<PaginationNotifier<Message>,
    AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (_) async {
      final repo = ref.watch(greetingRepositoryProvider);
      final message = await repo.getMessageById('1');

      return PaginatedFetchResult(
        entities: [
          message,
        ],
      );
    },
  )..init(),
);

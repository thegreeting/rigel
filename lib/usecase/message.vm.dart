import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/usecase/util/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interface_adapter/repository/greeting.repository.dart';
import 'ethereum_connector.vm.dart';

final messagesProviders = StateNotifierProvider.family<PaginationNotifier<Message>,
    AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (_) async {
      final repo = ref.watch(greetingRepositoryProvider);
      // TODO(knaoe): retrieve my message ids from campaign
      final messageIds = await repo.getMessageIds(
        campaignId,
        ref.watch(myWalletAccountProvider)!.id,
        MessageType.incoming,
      );
      final messages = await Future.wait(
        messageIds.map((id) => repo.getMessageById(campaignId, id)),
      );

      return PaginatedFetchResult(
        entities: [
          ...messages,
        ],
      );
    },
  )..init(),
);

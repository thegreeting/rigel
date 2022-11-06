import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/usecase/util/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interface_adapter/repository/greeting.repository.dart';
import 'ethereum_connector.vm.dart';

final currentMessageTypeProvider =
    StateProvider<MessageType>((_) => MessageType.incoming);

final incomingMessagesProviders = StateNotifierProvider.family<
    PaginationNotifier<Message>, AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (meta) {
      return innterFetchNextItems(meta, ref, campaignId, MessageType.incoming);
    },
  )..init(),
);

final sentMessagesProviders = StateNotifierProvider.family<PaginationNotifier<Message>,
    AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (meta) {
      return innterFetchNextItems(meta, ref, campaignId, MessageType.sent);
    },
  )..init(),
);

Future<PaginatedFetchResult<Message>> innterFetchNextItems(
  PaginationMeta meta,
  Ref ref,
  String campaignId,
  MessageType type,
) async {
  final repo = ref.watch(greetingRepositoryProvider);
  final messageIds = await repo.getMessageIds(
    campaignId,
    ref.watch(myWalletAccountProvider)!.id,
    type,
  );

  final messages = await Future.wait(
    messageIds.map((id) => repo.getMessageById(campaignId, id)),
  );

  return PaginatedFetchResult(
    entities: [
      ...messages,
    ],
  );
}

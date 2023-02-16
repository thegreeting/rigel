import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/usecase/util/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/messsage/message_type.enum.dart';
import 'ethereum_connector.vm.dart';

final currentMessageTypeProvider =
    StateProvider<MessageType>((_) => MessageType.incoming);

final incomingMessagesProviders = StateNotifierProvider.family<
    PaginationNotifier<Message>, AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (meta) {
      return innerFetchNextItems(meta, ref, campaignId, MessageType.incoming);
    },
  )..init(),
);

final sentMessagesProviders = StateNotifierProvider.family<PaginationNotifier<Message>,
    AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (meta) {
      return innerFetchNextItems(meta, ref, campaignId, MessageType.sent);
    },
  )..init(),
);

Future<PaginatedFetchResult<Message>> innerFetchNextItems(
  PaginationMeta meta,
  Ref ref,
  String campaignId,
  MessageType type,
) async {
  final repo = await ref.watch(greetingRepositoryProvider.future);
  final messageIds = await repo.getMessageIds(
    campaignId,
    ref.watch(myWalletAccountProvider)!.id,
    type,
  );

  final messages = await Future.wait(
    messageIds.map((id) => repo.getMessageById(campaignId, id)),
  );

  messages.sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));

  return PaginatedFetchResult(
    entities: [
      ...messages,
    ],
  );
}

import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/usecase/util/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesProviders = StateNotifierProvider.family<PaginationNotifier<Message>,
    AsyncValue<List<Message>>, String>(
  (ref, campaignId) => PaginationNotifier<Message>(
    fetchNextItems: (_) async {
      return const PaginatedFetchResult.empty();
    },
  )..init(),
);

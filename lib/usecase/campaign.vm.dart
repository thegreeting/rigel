import 'package:altair/domain/entity/campaign/greeting_word.entity.dart';
import 'package:altair/domain/entity/exception/network_exception.entity.dart';
import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/campaign/campaign.entity.dart';

final currentCampaignProvider = FutureProvider<Campaign>((ref) async {
  final repository = ref.watch(greetingRepositoryProvider);
  final campaigns = await repository.getShallowCampaigns();

  if (campaigns.isEmpty) {
    throw NotFound();
  }

  // TODO(knaoe): select campaign UI for future work.
  final firstCampaigns = campaigns.first;

  return Campaign(
    id: firstCampaigns.id,
    name: firstCampaigns.name,
    startDate: DateTime(2022, 11, 4, 2),
    endDate: DateTime(
      2022,
      11,
      6,
      23,
      59,
    ),
    currency: 'ETH',
    pricePerMessage: BigInt.from(.025 * 1e18),
    greetingWords: [
      const GreetingWord(id: '0', name: 'Hello:)'),
      const GreetingWord(id: '1', name: 'LGTM!'),
      const GreetingWord(id: '2', name: 'I\'m good!'),
      const GreetingWord(id: '3', name: '🤩🤤😱🤓'),
    ],
  );
});

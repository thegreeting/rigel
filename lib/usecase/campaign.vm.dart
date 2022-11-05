import 'package:altair/domain/entity/campaign/greeting_word.entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/campaign/campaign.entity.dart';

final currentCampaignProvider = FutureProvider<Campaign>((ref) async {
  // final connector = ref.watch(ethereumConnectorProvider);
  // final wordsRaw = await connector.callContract(
  //   greetingCampaignContract,
  //   'getMessageIds',
  // );

  return Campaign(
    id: 'network.greeting.ETHSF22',
    name: 'ETH SF',
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

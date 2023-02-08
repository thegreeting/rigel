import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/campaign/campaign.entity.dart';

final currentCampaignProvider = StateProvider<ShallowCampaign?>((ref) {
  final campaigns = ref.watch(campaignsProvider);

  if (!campaigns.hasValue) {
    return null;
  } else {
    return campaigns.value!.first;
  }

  // return Campaign(
  //   id: firstCampaigns.id,
  //   name: firstCampaigns.name,
  //   startDate: DateTime(2022, 11, 4, 2),
  //   endDate: DateTime(
  //     2022,
  //     11,
  //     6,
  //     23,
  //     59,
  //   ),
  //   currency: 'ETH',
  //   pricePerMessage: BigInt.from(.025 * 1e18),
  //   greetingWords: [
  //     const GreetingWord(id: '0', name: 'Hello:)'),
  //     const GreetingWord(id: '1', name: 'LGTM!'),
  //     const GreetingWord(id: '2', name: 'I\'m good!'),
  //     const GreetingWord(id: '3', name: '🤩🤤😱🤓'),
  //   ],
  // );
});

final campaignsProvider = FutureProvider<List<ShallowCampaign>>((ref) async {
  final repository = await ref.watch(greetingRepositoryProvider.future);
  return repository.getShallowCampaigns();
});

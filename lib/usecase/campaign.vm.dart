import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/campaign/campaign.entity.dart';

final currentCampaignProvider = Provider<Campaign>((ref) {
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
  );
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import 'ethereum_connector.vm.dart';

final toAddressProvider = StateProvider<String?>((ref) => null);

final bodyProvider = StateProvider<String?>((ref) => null);

final currentPricePerMessageInWeiProvider =
    FutureProvider.family<EtherAmount, String>((ref, campaignId) async {
  final repository = ref.watch(greetingRepositoryProvider);
  return repository.getPricePerMessageInWei(campaignId);
});

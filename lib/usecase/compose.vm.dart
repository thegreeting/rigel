import 'package:altair/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../interface_adapter/repository/ipfs_connector.dart';
import 'campaign.vm.dart';
import 'ethereum_connector.vm.dart';

final toAddressProvider = StateProvider<String?>((ref) => null);

final bodyProvider = StateProvider<String?>((ref) => null);

final currentPricePerMessageInWeiProvider =
    FutureProvider.family<EtherAmount, String>((ref, campaignId) async {
  final repository = ref.watch(greetingRepositoryProvider);
  return repository.getPricePerMessageInWei(campaignId);
});

Future<Map<String, dynamic>> buildMetadata(WidgetRef ref, String description) async {
  final campaign = ref.read(currentCampaignProvider);
  final senderAddress = ref.read(myWalletAddressProvider);
  if (senderAddress == null) {
    throw Exception('sender address is null');
  }

  final senderName =
      await ref.read(walletDisplayAddressOrNameProviders(senderAddress.hex).future);
  final campaignName = campaign?.name ?? 'Unknown Campaign';
  final metadata = {
    'version': {
      'standard': 'NFT1',
      'minting_tool': 'The Greeting - Rigel',
    },
    'name': 'from $senderName in $campaignName',
    'description': description,
  };
  logger.info('metadata: $metadata');
  return metadata;
}

Future<String> storeMetadataOnDecentralizedStorage(Map<String, dynamic> data) async {
  final ipfs = IpfsConnector();
  final cid = await ipfs.addJson(data);
  return 'ipfs://$cid';
}

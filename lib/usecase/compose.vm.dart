import 'package:altair/logger.dart';
import 'package:altair/usecase/greeting_word.vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../interface_adapter/repository/ipfs_connector.dart';
import 'ethereum_connector.vm.dart';

final toAddressProvider = StateProvider<String?>((ref) => null);

final bodyProvider = StateProvider<String?>((ref) => null);

final currentPricePerMessageInWeiProvider =
    FutureProvider.family<EtherAmount, String>((ref, campaignId) async {
  final repository = ref.watch(greetingRepositoryProvider);
  return repository.getPricePerMessageInWei(campaignId);
});

Future<Map<String, dynamic>> buildMetadata(
  WidgetRef ref,
  String campaignId,
  String description,
) async {
  final senderAddress = ref.read(myWalletAddressProvider);
  if (senderAddress == null) {
    throw Exception('sender address is null');
  }
  final selectedGreetingWordAsyncValue =
      ref.read(selectedGreetingWordStateNotifierProvider(campaignId));

  final selectedGreetingWord = await (() async {
    if (!selectedGreetingWordAsyncValue.hasValue) {
      final repo = ref.read(greetingRepositoryProvider);
      return repo.getSelectedGreetingWord(campaignId, senderAddress.hex);
    } else {
      return selectedGreetingWordAsyncValue.value;
    }
  })();
  if (selectedGreetingWord == null) {
    throw Exception('selected greeting word is null');
  }

  final senderName =
      await ref.read(walletDisplayAddressOrNameProviders(senderAddress.hex).future);
  final metadata = {
    'version': {
      'standard': 'NFT1',
      'minting_tool': 'Rigel by The Greeting',
    },
    'name': 'from $senderName',
    'description': description,
    'image':
        'https://placehold.jp/fff/512x512.png?text=${selectedGreetingWord.name}&css=%7B%22font-weight%22%3A%22%20bold%22%2C%22background%22%3A%22%20-webkit-gradient(linear%2C%20left%20top%2C%20right%20bottom%2C%20from(%2377bb41)%2C%20to(%23ebf38f))%22%7D',
    'attributes': [
      {
        'trait_type': 'Greeting Word',
        'value': selectedGreetingWord.name,
      }
    ],
  };
  logger.info('metadata: $metadata');
  return metadata;
}

Future<String> storeMetadataOnDecentralizedStorage(Map<String, dynamic> data) async {
  final ipfs = IpfsConnector();
  final cid = await ipfs.addJson(data);
  return 'ipfs://$cid';
}

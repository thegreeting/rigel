import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Flavor {
  testnet,
  mainnet,
}

final flavorProvider = StateProvider<Flavor>((_) => loadFlavor());

Flavor loadFlavor() {
  const flavorStr = String.fromEnvironment('FLAVOR');
  switch (flavorStr) {
    case 'testnet':
      return Flavor.testnet;
    case 'mainnet':
    default:
      return Flavor.mainnet;
  }
}

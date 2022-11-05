import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Flavor {
  local,
  staging,
  production,
}

final flavorProvider = StateProvider<Flavor>((_) => loadFlavor());

Flavor loadFlavor() {
  const flavorStr = String.fromEnvironment('FLAVOR');
  switch (flavorStr) {
    case 'local':
      return Flavor.local;
    case 'staging':
      return Flavor.staging;
    case 'production':
    default:
      return Flavor.production;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interface_adapter/repository/ethereum_connector.dart';
import '../interface_adapter/repository/greeting.repository.dart';

final ethereumConnectorProvider = Provider<EthereumConnector>((ref) {
  return EthereumConnector();
});

final greetingRepositoryProvider = Provider<GreetingRepository>((ref) {
  return GreetingRepository(
    ref.watch(ethereumConnectorProvider),
  );
});

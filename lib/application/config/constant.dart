import 'package:altair/application/config/config.dart';
import 'package:altair/util/flavor.provider.dart';

mixin AppConstant {
  static const String theGreetingFacadeContractName = 'facade.thegreeting.eth';
  static const String ethMainnetRpcUrl =
      'https://mainnet.infura.io/v3/989337b06e1a4ad1a200faec47c291ce';
  static const String ethGoerliRpcUrl =
      'https://goerli.infura.io/v3/989337b06e1a4ad1a200faec47c291ce';
  static const String goerliEnsResolverAddress =
      '0xE264d5bb84bA3b8061ADC38D3D76e6674aB91852';

  static String getEthRpcUrl([Flavor? flavor]) {
    final resolvedFlavor = flavor ?? App.flavor;
    switch (resolvedFlavor) {
      case Flavor.testnet:
        return ethGoerliRpcUrl;
      case Flavor.mainnet:
        return ethMainnetRpcUrl;
    }
  }

  static int getChainId([Flavor? flavor]) {
    final resolvedFlavor = flavor ?? App.flavor;
    switch (resolvedFlavor) {
      case Flavor.testnet:
        return 5; // Goerli
      case Flavor.mainnet:
        return 1;
    }
  }
}

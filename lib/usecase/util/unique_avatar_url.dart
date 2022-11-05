import 'package:web3dart/web3dart.dart';

String buildEthereumAvatar(EthereumAddress address) {
  return buildUniqueAvatarUrl(address.hex);
}

String buildUniqueAvatarUrl(String id) {
  return 'https://effigy.im/a/$id.png';
}

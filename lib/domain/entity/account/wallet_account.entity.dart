import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

import '../../../usecase/util/unique_avatar_url.dart';

part 'wallet_account.entity.freezed.dart';
part 'wallet_account.entity.g.dart';

// https://schema.org/Person

@freezed
class WalletAccount with _$WalletAccount {
  const factory WalletAccount({
    // https://schema.org/Thing
    required String id,
    required String name,
    String? description,
    String? url,
    String? image,
    // --
    String? nameForAvatar,
  }) = _WalletAccount;
  const WalletAccount._();

  factory WalletAccount.fromWalletAddress(EthereumAddress address) => WalletAccount(
        id: address.hex,
        name: address.hex.substring(0, 8),
        image: buildEthereumAvatar(address),
        nameForAvatar: address.hex.substring(2, 4),
      );

  factory WalletAccount.fromJson(Map<String, dynamic> json) =>
      _$WalletAccountFromJson(json);
}

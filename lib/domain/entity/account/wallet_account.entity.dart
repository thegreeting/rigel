import 'package:freezed_annotation/freezed_annotation.dart';

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

  factory WalletAccount.fromJson(Map<String, dynamic> json) =>
      _$WalletAccountFromJson(json);
}

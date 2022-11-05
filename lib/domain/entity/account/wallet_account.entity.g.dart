// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_account.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletAccount _$$_WalletAccountFromJson(Map<String, dynamic> json) =>
    _$_WalletAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      nameForAvatar: json['nameForAvatar'] as String?,
    );

Map<String, dynamic> _$$_WalletAccountToJson(_$_WalletAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'image': instance.image,
      'nameForAvatar': instance.nameForAvatar,
    };

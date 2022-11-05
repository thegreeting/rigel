// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Campaign _$$_CampaignFromJson(Map<String, dynamic> json) => _$_Campaign(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      currency: json['currency'] as String,
      pricePerMessage: BigInt.parse(json['pricePerMessage'] as String),
      greetingWords: (json['greetingWords'] as List<dynamic>)
          .map((e) => GreetingWord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CampaignToJson(_$_Campaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'currency': instance.currency,
      'pricePerMessage': instance.pricePerMessage.toString(),
      'greetingWords': instance.greetingWords,
    };

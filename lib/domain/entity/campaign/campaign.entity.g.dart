// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, mixin_inherits_from_not_object

part of 'campaign.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Campaign _$$_CampaignFromJson(Map<String, dynamic> json) => _$_Campaign(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      currency: json['currency'] as String,
      pricePerMessage: BigInt.parse(json['price_per_message'] as String),
      greetingWords: (json['greeting_words'] as List<dynamic>)
          .map((e) => GreetingWord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CampaignToJson(_$_Campaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'currency': instance.currency,
      'price_per_message': instance.pricePerMessage.toString(),
      'greeting_words': instance.greetingWords,
    };

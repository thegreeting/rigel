// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, mixin_inherits_from_not_object

part of 'message.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String,
      url: json['url'] as String?,
      contentReferenceTime: json['content_reference_time'] == null
          ? null
          : DateTime.parse(json['content_reference_time'] as String),
      dateCreated: DateTime.parse(json['date_created'] as String),
      dateRead: json['date_read'] == null
          ? null
          : DateTime.parse(json['date_read'] as String),
      dateReceived: json['date_received'] == null
          ? null
          : DateTime.parse(json['date_received'] as String),
      dateSent: json['date_sent'] == null
          ? null
          : DateTime.parse(json['date_sent'] as String),
      recipient:
          WalletAccount.fromJson(json['recipient'] as Map<String, dynamic>),
      sender: WalletAccount.fromJson(json['sender'] as Map<String, dynamic>),
      greetingWord: json['greeting_word'] as String,
      isResonanced: json['is_resonanced'] as bool? ?? false,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.waitingForReply,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'content_reference_time':
          instance.contentReferenceTime?.toIso8601String(),
      'date_created': instance.dateCreated.toIso8601String(),
      'date_read': instance.dateRead?.toIso8601String(),
      'date_received': instance.dateReceived?.toIso8601String(),
      'date_sent': instance.dateSent?.toIso8601String(),
      'recipient': instance.recipient,
      'sender': instance.sender,
      'greeting_word': instance.greetingWord,
      'is_resonanced': instance.isResonanced,
      'status': _$MessageStatusEnumMap[instance.status]!,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.waitingForReply: 'waitingForReply',
  MessageStatus.replied: 'replied',
};

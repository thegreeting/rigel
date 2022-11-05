// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String,
      url: json['url'] as String?,
      contentReferenceTime: json['contentReferenceTime'] == null
          ? null
          : DateTime.parse(json['contentReferenceTime'] as String),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateRead: json['dateRead'] == null
          ? null
          : DateTime.parse(json['dateRead'] as String),
      dateReceived: json['dateReceived'] == null
          ? null
          : DateTime.parse(json['dateReceived'] as String),
      dateSent: json['dateSent'] == null
          ? null
          : DateTime.parse(json['dateSent'] as String),
      recipient:
          WalletAccount.fromJson(json['recipient'] as Map<String, dynamic>),
      sender: WalletAccount.fromJson(json['sender'] as Map<String, dynamic>),
      greetingWord: json['greetingWord'] as String,
      isResonanced: json['isResonanced'] as bool? ?? false,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.waitingForReply,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'contentReferenceTime': instance.contentReferenceTime?.toIso8601String(),
      'dateCreated': instance.dateCreated.toIso8601String(),
      'dateRead': instance.dateRead?.toIso8601String(),
      'dateReceived': instance.dateReceived?.toIso8601String(),
      'dateSent': instance.dateSent?.toIso8601String(),
      'recipient': instance.recipient,
      'sender': instance.sender,
      'greetingWord': instance.greetingWord,
      'isResonanced': instance.isResonanced,
      'status': _$MessageStatusEnumMap[instance.status]!,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.waitingForReply: 'waitingForReply',
  MessageStatus.replied: 'replied',
};

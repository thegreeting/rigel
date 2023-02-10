import 'package:altair/domain/entity/account/wallet_account.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../primitive/image_object.entity.dart';
import '../primitive/person.entity.dart';

part 'message.entity.freezed.dart';
part 'message.entity.g.dart';

enum MessageStatus {
  waitingForReply(0),
  replied(1);

  const MessageStatus(this.value);
  factory MessageStatus.fromValue(int value) {
    return MessageStatus.values.firstWhere((e) => e.value == value);
  }
  final int value;
}

@freezed
class Message with _$Message {
  const factory Message({
    // https://schema.org/Thing
    required String id,
    String? name,
    required String description,
    String? url,
    required ImageObject image, // representative image
    // https://schema.org/CreativeWork
    required Person author,
    DateTime? contentReferenceTime,
    required DateTime dateCreated,
    // https://schema.org/Message
    DateTime? dateRead,
    DateTime? dateReceived,
    DateTime? dateSent,
    required WalletAccount recipient,
    required WalletAccount sender,
    // --
    required String greetingWord,
    @Default(false) bool isResonanced,
    @Default(MessageStatus.waitingForReply) MessageStatus status,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

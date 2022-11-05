import 'package:altair/domain/entity/account/wallet_account.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.entity.freezed.dart';
part 'message.entity.g.dart';

enum MessageStatus {
  waitingForReply,
  replied,
}

@freezed
class Message with _$Message {
  const factory Message({
    // https://schema.org/Thing
    required String id,
    String? name,
    required String description,
    String? url,
    // required ImageObject image, // representative image
    // https://schema.org/CreativeWork
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

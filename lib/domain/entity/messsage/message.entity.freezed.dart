// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
// https://schema.org/Thing
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get url =>
      throw _privateConstructorUsedError; // required ImageObject image, // representative image
// https://schema.org/CreativeWork
  DateTime? get contentReferenceTime => throw _privateConstructorUsedError;
  DateTime get dateCreated =>
      throw _privateConstructorUsedError; // https://schema.org/Message
  DateTime? get dateRead => throw _privateConstructorUsedError;
  DateTime? get dateReceived => throw _privateConstructorUsedError;
  DateTime? get dateSent => throw _privateConstructorUsedError;
  WalletAccount get recipient => throw _privateConstructorUsedError;
  WalletAccount get sender => throw _privateConstructorUsedError; // --
  String get greetingWord => throw _privateConstructorUsedError;
  bool get isResonanced => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String description,
      String? url,
      DateTime? contentReferenceTime,
      DateTime dateCreated,
      DateTime? dateRead,
      DateTime? dateReceived,
      DateTime? dateSent,
      WalletAccount recipient,
      WalletAccount sender,
      String greetingWord,
      bool isResonanced,
      MessageStatus status});

  $WalletAccountCopyWith<$Res> get recipient;
  $WalletAccountCopyWith<$Res> get sender;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = null,
    Object? url = freezed,
    Object? contentReferenceTime = freezed,
    Object? dateCreated = null,
    Object? dateRead = freezed,
    Object? dateReceived = freezed,
    Object? dateSent = freezed,
    Object? recipient = null,
    Object? sender = null,
    Object? greetingWord = null,
    Object? isResonanced = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      contentReferenceTime: freezed == contentReferenceTime
          ? _value.contentReferenceTime
          : contentReferenceTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateRead: freezed == dateRead
          ? _value.dateRead
          : dateRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateReceived: freezed == dateReceived
          ? _value.dateReceived
          : dateReceived // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateSent: freezed == dateSent
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as WalletAccount,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as WalletAccount,
      greetingWord: null == greetingWord
          ? _value.greetingWord
          : greetingWord // ignore: cast_nullable_to_non_nullable
              as String,
      isResonanced: null == isResonanced
          ? _value.isResonanced
          : isResonanced // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WalletAccountCopyWith<$Res> get recipient {
    return $WalletAccountCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WalletAccountCopyWith<$Res> get sender {
    return $WalletAccountCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String description,
      String? url,
      DateTime? contentReferenceTime,
      DateTime dateCreated,
      DateTime? dateRead,
      DateTime? dateReceived,
      DateTime? dateSent,
      WalletAccount recipient,
      WalletAccount sender,
      String greetingWord,
      bool isResonanced,
      MessageStatus status});

  @override
  $WalletAccountCopyWith<$Res> get recipient;
  @override
  $WalletAccountCopyWith<$Res> get sender;
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$_Message>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = null,
    Object? url = freezed,
    Object? contentReferenceTime = freezed,
    Object? dateCreated = null,
    Object? dateRead = freezed,
    Object? dateReceived = freezed,
    Object? dateSent = freezed,
    Object? recipient = null,
    Object? sender = null,
    Object? greetingWord = null,
    Object? isResonanced = null,
    Object? status = null,
  }) {
    return _then(_$_Message(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      contentReferenceTime: freezed == contentReferenceTime
          ? _value.contentReferenceTime
          : contentReferenceTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateRead: freezed == dateRead
          ? _value.dateRead
          : dateRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateReceived: freezed == dateReceived
          ? _value.dateReceived
          : dateReceived // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateSent: freezed == dateSent
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as WalletAccount,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as WalletAccount,
      greetingWord: null == greetingWord
          ? _value.greetingWord
          : greetingWord // ignore: cast_nullable_to_non_nullable
              as String,
      isResonanced: null == isResonanced
          ? _value.isResonanced
          : isResonanced // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message(
      {required this.id,
      this.name,
      required this.description,
      this.url,
      this.contentReferenceTime,
      required this.dateCreated,
      this.dateRead,
      this.dateReceived,
      this.dateSent,
      required this.recipient,
      required this.sender,
      required this.greetingWord,
      this.isResonanced = false,
      this.status = MessageStatus.waitingForReply});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

// https://schema.org/Thing
  @override
  final String id;
  @override
  final String? name;
  @override
  final String description;
  @override
  final String? url;
// required ImageObject image, // representative image
// https://schema.org/CreativeWork
  @override
  final DateTime? contentReferenceTime;
  @override
  final DateTime dateCreated;
// https://schema.org/Message
  @override
  final DateTime? dateRead;
  @override
  final DateTime? dateReceived;
  @override
  final DateTime? dateSent;
  @override
  final WalletAccount recipient;
  @override
  final WalletAccount sender;
// --
  @override
  final String greetingWord;
  @override
  @JsonKey()
  final bool isResonanced;
  @override
  @JsonKey()
  final MessageStatus status;

  @override
  String toString() {
    return 'Message(id: $id, name: $name, description: $description, url: $url, contentReferenceTime: $contentReferenceTime, dateCreated: $dateCreated, dateRead: $dateRead, dateReceived: $dateReceived, dateSent: $dateSent, recipient: $recipient, sender: $sender, greetingWord: $greetingWord, isResonanced: $isResonanced, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Message &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.contentReferenceTime, contentReferenceTime) ||
                other.contentReferenceTime == contentReferenceTime) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.dateRead, dateRead) ||
                other.dateRead == dateRead) &&
            (identical(other.dateReceived, dateReceived) ||
                other.dateReceived == dateReceived) &&
            (identical(other.dateSent, dateSent) ||
                other.dateSent == dateSent) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.greetingWord, greetingWord) ||
                other.greetingWord == greetingWord) &&
            (identical(other.isResonanced, isResonanced) ||
                other.isResonanced == isResonanced) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      url,
      contentReferenceTime,
      dateCreated,
      dateRead,
      dateReceived,
      dateSent,
      recipient,
      sender,
      greetingWord,
      isResonanced,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String id,
      final String? name,
      required final String description,
      final String? url,
      final DateTime? contentReferenceTime,
      required final DateTime dateCreated,
      final DateTime? dateRead,
      final DateTime? dateReceived,
      final DateTime? dateSent,
      required final WalletAccount recipient,
      required final WalletAccount sender,
      required final String greetingWord,
      final bool isResonanced,
      final MessageStatus status}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override // https://schema.org/Thing
  String get id;
  @override
  String? get name;
  @override
  String get description;
  @override
  String? get url;
  @override // required ImageObject image, // representative image
// https://schema.org/CreativeWork
  DateTime? get contentReferenceTime;
  @override
  DateTime get dateCreated;
  @override // https://schema.org/Message
  DateTime? get dateRead;
  @override
  DateTime? get dateReceived;
  @override
  DateTime? get dateSent;
  @override
  WalletAccount get recipient;
  @override
  WalletAccount get sender;
  @override // --
  String get greetingWord;
  @override
  bool get isResonanced;
  @override
  MessageStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

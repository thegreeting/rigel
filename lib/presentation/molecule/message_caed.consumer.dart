import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../application/config/color_scheme.dart';
import '../../domain/entity/account/wallet_account.entity.dart';
import '../../domain/entity/messsage/message.entity.dart';
import '../../domain/entity/primitive/image_object.entity.dart';
import '../atom/ethereum_address.dart';
import '../atom/single_image.dart';
import '../atom/title_text.dart';

abstract class MessageCard extends ConsumerWidget {
  const MessageCard({
    super.key,
    required this.id,
    required this.image,
    required this.greetingWord,
    required this.description,
    required this.isResonanced,
    required this.sender,
    required this.recipient,
  });

  MessageCard.fromEntity(
    Message e, {
    super.key,
  })  : id = e.id,
        image = e.image,
        greetingWord = e.greetingWord,
        description = e.description,
        isResonanced = e.isResonanced,
        sender = e.sender,
        recipient = e.recipient;

  final String id;
  final ImageObject image;
  final String greetingWord;
  final String description;
  final bool isResonanced;
  final WalletAccount sender;
  final WalletAccount recipient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color:
          AppPalette.scheme.secondaryContainer.maybeResolve(context)!.withOpacity(.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: AppPalette.scheme.secondaryContainer.maybeResolve(context),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleImage(
                      image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TitleText(
                        '#$id',
                        style: TextStyle(
                          color: AppPalette.scheme.onPrimary.maybeResolve(context),
                        ),
                      ),
                    ),
                  ),
                  if (isResonanced)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Resonanced',
                          style: TextStyle(
                            color: AppPalette.scheme.onPrimary.maybeResolve(context),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  greetingWord,
                  style: const TextStyle(fontSize: 24),
                ),
                const Gap(4),
                Text(description),
                buildSenderOrRecipient(context, ref),
              ],
            ),
          ),
          buildBottom(context, ref),
        ],
      ),
    );
  }

  Widget buildSenderOrRecipient(BuildContext context, WidgetRef ref);
  Widget buildBottom(BuildContext context, WidgetRef ref) {
    return const SizedBox();
  }
}

class IncomingMessageCard extends MessageCard {
  const IncomingMessageCard({
    super.key,
    required super.id,
    required super.image,
    required super.greetingWord,
    required super.description,
    required super.isResonanced,
    required super.sender,
    required super.recipient,
  });

  IncomingMessageCard.fromEntity(
    super.e, {
    super.key,
  }) : super.fromEntity();

  @override
  Widget buildSenderOrRecipient(BuildContext context, WidgetRef ref) {
    return EthereumAddressText(sender.name);
  }

  @override
  Widget buildBottom(BuildContext context, WidgetRef ref) {
    return const ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: null,
          child: Text('Reply'),
        ),
      ],
    );
  }
}

class OutgoingMessageCard extends MessageCard {
  const OutgoingMessageCard({
    super.key,
    required super.id,
    required super.image,
    required super.greetingWord,
    required super.description,
    required super.isResonanced,
    required super.sender,
    required super.recipient,
  });

  OutgoingMessageCard.fromEntity(
    super.e, {
    super.key,
  }) : super.fromEntity();

  @override
  Widget buildSenderOrRecipient(BuildContext context, WidgetRef ref) {
    return EthereumAddressText(recipient.name);
  }
}

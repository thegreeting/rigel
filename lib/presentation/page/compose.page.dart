import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:web3dart/web3dart.dart';

import '../../application/config/color_scheme.dart';
import '../../domain/entity/exception/user_activity_exception.entity.dart';
import '../../logger.dart';
import '../../usecase/compose.vm.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../../usecase/greeting_word.vm.dart';
import '../atom/caption_text.dart';
import '../atom/simple_info.dart';
import '../atom/title_text.dart';
import '../template/loading.template.page.dart';
import '../util/exception_guard.dart';
import '../util/ui_guard.dart';

class ComposePage extends ConsumerWidget {
  const ComposePage({
    super.key,
    required this.campaignId,
  });

  final String campaignId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myWalletAccount = ref.watch(myWalletAccountProvider);
    final greetingWordAsyncValue = ref.watch(
      selectedGreetingWordStateNotifierProvider(campaignId),
    );
    final pricePerMessageInWeiAsyncValue = ref.watch(
      currentPricePerMessageInWeiProvider(campaignId),
    );

    if (myWalletAccount == null) {
      context.go('/');
      return const LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your message'),
        actions: [
          TextButton(
            onPressed: () => onSend(context, ref),
            child: const Text('Send'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CaptionText(
                          'On-Chain',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppPalette.scheme.primary.maybeResolve(context),
                          ),
                        ),
                      ),
                      greetingWordAsyncValue.when(
                        data: (word) => Center(
                          child: TitleText(
                            word.name,
                            style: const TextStyle(fontSize: 44),
                          ),
                        ),
                        loading: PlatformCircularProgressIndicator.new,
                        error: (error, stack) => const SimpleInfo(
                          message:
                              'Failed to load greeting word. Please restart app and try again.',
                        ),
                      ),
                      const Gap(16),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.contact_mail),
                          labelText: 'To',
                          hintText: 'address(0x) or ENS name',
                        ),
                        onChanged: (addressOrName) async {
                          final isAddress = addressOrName.startsWith('0x');
                          try {
                            final value = isAddress
                                ? addressOrName
                                : (await getAddressWithENSName(
                                    ref,
                                    addressOrName,
                                  ))
                                    .hex;
                            logger.fine(value);
                            ref
                                .read(toAddressProvider.notifier)
                                .update((state) => value);
                            // ignore: avoid_catches_without_on_clauses
                          } catch (e) {
                            logger.fine('wrong value');
                          }
                        },
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
              Card(
                color: AppPalette.scheme.secondary.maybeResolve(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: CaptionText('Off-Chain'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.short_text),
                          labelText: 'Body',
                          hintText: 'Write your message here',
                        ),
                        maxLines: 3,
                        onChanged: (value) async {
                          ref.read(bodyProvider.notifier).update((state) => value);
                        },
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              pricePerMessageInWeiAsyncValue.when(
                data: (price) => Center(
                  child: Text(
                    '${price.getValueInUnit(EtherUnit.ether)} ETH/message',
                  ),
                ),
                loading: PlatformCircularProgressIndicator.new,
                error: (error, stack) => const SimpleInfo(
                  message:
                      'Failed to load price per message. Please restart app and try again.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSend(BuildContext context, WidgetRef ref) async {
    final repo = await ref.read(greetingRepositoryProvider.future);
    final pricePerMessageAmount =
        await ref.read(currentPricePerMessageInWeiProvider(campaignId).future);
    final currentBalanceAmount = await ref.read(myWalletAmountProvider.future);
    final toAddress = ref.read(toAddressProvider);
    final body = ref.read(bodyProvider);

    logger
      ..info('to: $toAddress')
      ..info('body: $body');

    final messageUrl = await (() async {
      if (body != null) {
        final metadata = await buildMetadata(ref, campaignId, body);
        return storeMetadataOnDecentralizedStorage(metadata);
      } else {
        return '';
      }
    })();

    var txHash = '';
    await easyUIGuard(
      context,
      () async {
        await noticeableGuard(context, () async {
          if (currentBalanceAmount.getInEther.toDouble() <
              pricePerMessageAmount.getInEther.toDouble()) {
            throw InsufficientBalance();
          }

          if (toAddress == null) {
            throw Exception('To address is not set');
          }

          txHash = await repo.sendMessage(
            campaignId,
            receiverId: toAddress,
            amount: pricePerMessageAmount,
            messageUrl: messageUrl,
          );
        });
        return true;
      },
      message: 'Sending...\nCheck your connected wallet to confirm.',
    );

    await easyUIGuard(
      context,
      () async {
        await Future<void>.delayed(const Duration(seconds: 5));
        return true;
      },
      message: 'Confirming...\n$txHash',
    );
    context.go('/home');
  }
}

import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/domain/entity/exception/user_activity_exception.entity.dart';
import 'package:altair/logger.dart';
import 'package:altair/presentation/atom/caption_text.dart';
import 'package:altair/presentation/atom/simple_info.dart';
import 'package:altair/presentation/atom/title_text.dart';
import 'package:altair/presentation/template/loading.template.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:web3dart/web3dart.dart';

import '../../usecase/compose.vm.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../../usecase/greeting_word.vm.dart';
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
                    '${price.getValueInUnit(EtherUnit.ether).toString()} ETH/message',
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
    final repo = ref.read(greetingRepositoryProvider);
    final pricePerMessageAmount =
        await ref.read(currentPricePerMessageInWeiProvider(campaignId).future);
    final currentBalanceAmount = await ref.read(myWalletAmountProvider.future);
    final toAddress = ref.read(toAddressProvider);
    final body = ref.read(bodyProvider);

    logger
      ..info('to: $toAddress')
      ..info('body: $body');

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

          await repo.sendMessage(
            campaignId,
            receiverId: toAddress,
            amount: pricePerMessageAmount,
          );
          await Future<void>.delayed(const Duration(seconds: 10));
        });
        return true;
      },
      message: 'Sending...\nCheck your connected wallet to confirm.',
    );
    context.go('/home');
  }
}

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_grid/simple_grid.dart';
import 'package:web3dart/web3dart.dart';

import '../../domain/entity/campaign/campaign.entity.dart';
import '../../domain/entity/messsage/message_type.enum.dart';
import '../../usecase/campaign.vm.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../../usecase/greeting_word.vm.dart';
import '../../usecase/message.vm.dart';
import '../atom/avatar.dart';
import '../atom/ethereum_address.dart';
import '../atom/simple_info.dart';
import '../atom/title_text.dart';
import '../molecule/exception_info.dart';
import '../molecule/loading_info.dart';
import '../molecule/message_caed.consumer.dart';
import '../template/loading.template.page.dart';
import '../util/ui_guard.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaign = ref.watch(currentCampaignProvider);
    final myWalletAccount = ref.watch(myWalletAccountProvider);
    final messageType = ref.watch(currentMessageTypeProvider);

    if (myWalletAccount == null) {
      context.go('/');
      return const LoadingPage();
    }

    if (campaign == null) {
      return const LoadingPage(
        message: 'Loading campaigns from TheGreeting contract...',
      );
    }

    final messagesProvider = (() {
      switch (messageType) {
        case MessageType.incoming:
          return incomingMessagesProviders(campaign.id);
        case MessageType.sent:
          return sentMessagesProviders(campaign.id);
      }
    })();
    final messagesAsyncValue = ref.watch(messagesProvider);
    final selectedGreetingWordAsyncValue =
        ref.watch(selectedGreetingWordStateNotifierProvider(campaign.id));

    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          child: TitleText(campaign.name),
          onPressed: () async {
            final campaigns = await ref.watch(campaignsProvider.future);
            final selectedCampaign = await showConfirmationDialog<ShallowCampaign?>(
              context: context,
              title: 'Select a campaign',
              actions: [
                ...campaigns.map(
                  (e) => AlertDialogAction(
                    key: e,
                    label: e.name,
                  ),
                )
              ],
            );
            if (selectedCampaign != null && campaign != selectedCampaign) {
              ref
                  .read(currentCampaignProvider.notifier)
                  .update((state) => selectedCampaign);
              await showOkAlertDialog(
                context: context,
                message: 'Campaign switched to ${selectedCampaign.name}',
              );
            }
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              return ref.refresh(messagesProvider);
            },
          ),
          EthereumAddressText(myWalletAccount.id),
          IconButton(
            icon: SizedBox.square(
              dimension: 36,
              child: Avatar.fromWalletAccount(myWalletAccount),
            ),
            onPressed: () async {
              final currentBalance = await ref.read(myWalletAmountProvider.future);
              final ok = await showOkCancelAlertDialog(
                context: context,
                title: 'Your Wallet',
                message:
                    '${myWalletAccount.id}\nbalance: ${currentBalance.getValueInUnit(EtherUnit.ether)} ETH',
                okLabel: 'Disconnect',
                isDestructiveAction: true,
              );
              if (ok == OkCancelResult.ok) {
                await ref.read(connectionStateProvider.notifier).disconnect();
                context.go('/');
              }
            },
          ),
          const Gap(16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CupertinoSlidingSegmentedControl<MessageType>(
              groupValue: messageType,
              children: const {
                MessageType.incoming: Text('Incoming'),
                MessageType.sent: Text('Sent'),
              },
              onValueChanged: (value) {
                if (value != null) {
                  ref
                      .read(currentMessageTypeProvider.notifier)
                      .update((state) => value);
                }
              },
            ),
          ),
        ),
      ),
      body: messagesAsyncValue.when(
        data: (messages) {
          if (messages.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(44),
              child: Column(
                children: [
                  const SimpleInfo(
                    message: 'No messages yet',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return ref.refresh(messagesProvider);
                    },
                    child: const Text('Reload'),
                  )
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              return ref.refresh(messagesProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SpGrid(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final message in messages)
                    SpGridItem(
                      xs: 6,
                      sm: 4,
                      lg: 3,
                      child: messageType == MessageType.incoming
                          ? IncomingMessageCard.fromEntity(message)
                          : OutgoingMessageCard.fromEntity(message),
                    ),
                ],
              ),
            ),
          );
        },
        loading: LoadingInfo.new,
        error: (error, stackTrace) => RecoverableExceptionInfo.withStackTrace(
          error,
          stackTrace,
          onPressed: () => ref.refresh(incomingMessagesProviders(campaign.id)),
        ),
      ),
      floatingActionButton: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            selectedGreetingWordAsyncValue.when(
              data: (word) => SizedBox(
                width: 120,
                child: Text(
                  'Your selected word is "${word.name}"',
                  maxLines: 2,
                ),
              ),
              loading: Container.new,
              error: (e, __) => const SizedBox(
                width: 160,
                child: Text(
                  'Select your GreetingWord to compose message ->',
                  maxLines: 3,
                ),
              ),
            ),
            const Gap(16),
            FloatingActionButton(
              child: const Icon(Icons.create),
              onPressed: () async {
                final ok = await easyUIGuard(
                  context,
                  () async {
                    final wordAsyncValue = ref
                        .read(selectedGreetingWordStateNotifierProvider(campaign.id));
                    return wordAsyncValue.hasValue;
                  },
                  message: 'Checking your selected GreetingWord on the blockchain...',
                );

                if (ok) {
                  context.push('/campaigns/${campaign.id}/compose');
                } else {
                  context.push('/campaigns/${campaign.id}/select_greeting_word');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

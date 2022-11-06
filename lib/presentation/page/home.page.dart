import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/interface_adapter/repository/greeting.repository.dart';
import 'package:altair/presentation/atom/avatar.dart';
import 'package:altair/presentation/atom/caption_text.dart';
import 'package:altair/presentation/atom/simple_info.dart';
import 'package:altair/presentation/molecule/exception_info.dart';
import 'package:altair/presentation/molecule/loading_info.dart';
import 'package:altair/usecase/message.vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../usecase/campaign.vm.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../atom/title_text.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsyncValue = ref.watch(currentCampaignProvider);
    final myWalletAccount = ref.watch(myWalletAccountProvider);
    final messageType = ref.watch(currentMessageTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: campaignAsyncValue.when(
          data: (campaign) => Text(campaign.name),
          loading: PlatformCircularProgressIndicator.new,
          error: (_, __) => const Text('Error'),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: myWalletAccount == null
                ? const Icon(Icons.person)
                : SizedBox.square(
                    dimension: 36,
                    child: Avatar.fromWalletAccount(myWalletAccount),
                  ),
            onPressed: myWalletAccount == null
                ? null
                : () async {
                    final ok = await showOkCancelAlertDialog(
                      context: context,
                      title: 'Your Wallet address is',
                      message: myWalletAccount.id,
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
      body: campaignAsyncValue.when(
        data: (campaign) {
          final messageType = ref.watch(currentMessageTypeProvider);
          final messagesProvider = (() {
            switch (messageType) {
              case MessageType.incoming:
                return incomingMessagesProviders(campaign.id);
              case MessageType.sent:
                return sentMessagesProviders(campaign.id);
            }
          })();
          final messagesAsyncValue = ref.watch(messagesProvider);
          return messagesAsyncValue.when(
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
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        elevation: 0,
                        color: AppPalette.scheme.primaryContainer
                            .maybeResolve(context)!
                            .withOpacity(.4),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              ListTile(
                                title: TitleText(
                                  '#${message.id} ${message.greetingWord}',
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CaptionText('from: '),
                                    Expanded(
                                      child: Text(
                                        message.sender.name,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  const CaptionText('Resonanced?: '),
                                  Text(message.isResonanced.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: LoadingInfo.new,
            error: (error, stackTrace) => RecoverableExceptionInfo.withStackTrace(
              error,
              stackTrace,
              onPressed: () => ref.refresh(incomingMessagesProviders(campaign.id)),
            ),
          );
        },
        loading: () => const LoadingInfo(message: 'Loading campaign...'),
        error: (error, stackTrace) => RecoverableExceptionInfo.withStackTrace(
          error,
          stackTrace,
          onPressed: () => ref.refresh(currentCampaignProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          context.push('/select_greeting_word');
        },
      ),
    );
  }
}

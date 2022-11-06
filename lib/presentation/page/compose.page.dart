import 'package:altair/presentation/atom/simple_info.dart';
import 'package:altair/presentation/atom/title_text.dart';
import 'package:altair/presentation/template/loading.template.page.dart';
import 'package:altair/presentation/util/exception_guard.dart';
import 'package:altair/presentation/util/ui_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:web3dart/web3dart.dart';

import '../../usecase/compose.vm.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../../usecase/greeting_word.vm.dart';

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
        title: const Text('Write message'),
        actions: [
          TextButton(
            onPressed: () async {
              final repo = ref.read(greetingRepositoryProvider);
              final amountInWei = await ref
                  .read(currentPricePerMessageInWeiProvider(campaignId).future);

              await easyUIGuard(
                context,
                () async {
                  await noticeableGuard(context, () async {
                    await repo.sendMessage(
                      campaignId,
                      receiverId: '0x9548DfB15A47A3d7918E4BC92451E72112901131',
                      amount: amountInWei,
                    );
                  });
                  return true;
                },
                message: 'Sending...\nCheck your connected wallet to confirm.',
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
      body: ListView(
        children: [
          greetingWordAsyncValue.when(
            data: (word) => Center(child: TitleText(word.name)),
            loading: PlatformCircularProgressIndicator.new,
            error: (error, stack) => const SimpleInfo(
              message:
                  'Failed to load greeting word. Please restart app and try again.',
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
    );
  }
}

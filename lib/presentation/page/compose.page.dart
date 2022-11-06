import 'package:altair/presentation/atom/simple_info.dart';
import 'package:altair/presentation/atom/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    if (myWalletAccount == null) {
      context.go('/');
      return const Placeholder();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Write message'),
        actions: [
          TextButton(
            onPressed: () {},
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
          )
        ],
      ),
    );
  }
}

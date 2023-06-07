import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../usecase/greeting_word.vm.dart';
import '../atom/simple_info.dart';
import '../atom/title_text.dart';
import '../molecule/exception_info.dart';
import '../molecule/loading_info.dart';
import '../util/ui_guard.dart';

class SelectGreetingWordPage extends ConsumerWidget {
  const SelectGreetingWordPage({
    super.key,
    required this.campaignId,
  });

  final String campaignId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greetingWordsAsync = ref.watch(greetingWordsProviders(campaignId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greeting Word'),
      ),
      body: ListView(
        children: [
          const SimpleInfo(
            message:
                'Select greeting word.\nThis cannot be changed through the campaign.',
          ),
          const Gap(16),
          greetingWordsAsync.when(
            data: (words) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    for (final word in words)
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 140,
                              ),
                              child: Center(child: TitleText(word.name)),
                            ),
                          ),
                          onPressed: () async {
                            final okOrCancel = await showOkCancelAlertDialog(
                              context: context,
                              title: 'You are selecting "${word.name}"',
                              message: 'You cannot change this later in this campaign.',
                              okLabel: 'Yes, I select "${word.name}" this time',
                            );

                            if (okOrCancel == OkCancelResult.cancel) {
                              return;
                            }

                            // Preserve the selected word.
                            final ok = await easyUIGuard(
                              context,
                              () async {
                                await ref
                                    .read(
                                      selectedGreetingWordStateNotifierProvider(
                                        campaignId,
                                      ).notifier,
                                    )
                                    .select(word);
                                return true;
                              },
                              message:
                                  'Persisting to the blockchain...\nChack your wallet app to confirm the transaction.',
                            );
                            if (ok) {
                              await context.push('/campaigns/$campaignId/compose');
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
            loading: LoadingInfo.new,
            error: RecoverableExceptionInfo.withStackTrace,
          ),
        ],
      ),
    );
  }
}

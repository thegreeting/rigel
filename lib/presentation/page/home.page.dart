import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/presentation/atom/caption_text.dart';
import 'package:altair/presentation/molecule/exception_info.dart';
import 'package:altair/presentation/molecule/loading_info.dart';
import 'package:altair/usecase/message.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../usecase/campaign.vm.dart';
import '../atom/title_text.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsyncValue = ref.watch(currentCampaignProvider);

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
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
          const Gap(16),
        ],
      ),
      body: campaignAsyncValue.when(
        data: (campaign) {
          final messagesAsyncValue = ref.watch(messagesProviders(campaign.id));
          return messagesAsyncValue.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(
                  child: Text('No messages yet'),
                );
              }
              return ListView.builder(
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
                              title: TitleText(message.greetingWord),
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
              );
            },
            loading: LoadingInfo.new,
            error: RecoverableExceptionInfo.withStackTrace,
          );
        },
        loading: () => const LoadingInfo(message: 'Loading campaign...'),
        error: RecoverableExceptionInfo.withStackTrace,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {},
      ),
    );
  }
}

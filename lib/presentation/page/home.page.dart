import 'package:altair/presentation/molecule/exception_info.dart';
import 'package:altair/presentation/molecule/loading_info.dart';
import 'package:altair/usecase/message.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../usecase/campaign.vm.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaign = ref.watch(currentCampaignProvider);
    final messagesAsyncValue = ref.watch(messagesProviders(campaign.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(campaign.name),
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
      body: messagesAsyncValue.when(
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
              return ListTile(
                title: Text(message.sender.toString()),
                subtitle: Text(message.dateSent.toString()),
              );
            },
          );
        },
        loading: LoadingInfo.new,
        error: RecoverableExceptionInfo.withStackTrace,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {},
      ),
    );
  }
}

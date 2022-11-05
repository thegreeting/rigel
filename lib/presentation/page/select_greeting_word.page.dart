import 'package:altair/presentation/atom/simple_info.dart';
import 'package:altair/presentation/atom/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectGreetingWordPage extends ConsumerWidget {
  const SelectGreetingWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          TextButton(
            onPressed: () {
              context.push('/compose');
            },
            child: const TitleText('Hello!'),
          ),
        ],
      ),
    );
  }
}

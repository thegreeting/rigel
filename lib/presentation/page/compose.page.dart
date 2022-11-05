import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComposePage extends ConsumerWidget {
  const ComposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView(),
    );
  }
}

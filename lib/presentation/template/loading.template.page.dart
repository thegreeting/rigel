import 'package:flutter/material.dart';

import '../molecule/loading_info.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LoadingInfo(message: message),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../molecule/loading_info.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      body: LoadingInfo(message: message),
    );
  }
}

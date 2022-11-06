import 'dart:math';

import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webviewx/webviewx.dart';

class WorldIdPage extends ConsumerWidget {
  const WorldIdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebViewXPage(
      onVerified: () {
        ref.read(hasVerifiedPerson.notifier).update((state) => true);
      },
    );
  }
}

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    super.key,
    this.initialContent,
    this.onVerified,
  });

  final String? initialContent;
  final VoidCallback? onVerified;

  @override
  WebViewXPageState createState() => WebViewXPageState();
}

class WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController<dynamic> webviewController;
  final initialContent = '''
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset=utf-8>
  <title>World ID</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <script type="text/javascript" src="https://unpkg.com/@worldcoin/id/dist/world-id.js"></script>
</head>

<body>
  <div id="world-id-container"></div>
  <script>

    document.addEventListener("DOMContentLoaded", async function () {
      console.log("From World-ID");
      worldID.init('world-id-container', {
        debug: true, // to aid with debugging, remove in production
        enable_telemetry: true,
        action_id: 'wid_staging_16a48f71d4da3d5afda8350c4d33d148', // obtain this from developer.worldcoin.org
        signal: 'your_signal',
        on_success: (proof) => { 
          console.log(JSON.stringify(proof))
          passProofJsonString(JSON.stringify(proof))
        },
        on_error: (error) => console.error(error),
      })
    });
  </script>
</body>

</html>
''';
  final executeJsErrorMessage =
      'Failed to execute this task because the current content is (probably) URL that allows iframe embedding, on Web.\n\n'
      'A short reason for this is that, when a normal URL is embedded in the iframe, you do not actually own that content so you cant call your custom functions\n'
      '(read the documentation to find out why).';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worldcoin Humanity Verification'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildWebViewX(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: widget.initialContent ?? initialContent,
      initialSourceType: SourceType.html,
      height: screenSize.height * 2 / 3,
      width: min(screenSize.width * 0.8, 1024),
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) => debugPrint('A new page has started loading.'),
      onPageFinished: (src) => debugPrint('The page has finished loading.'),
      dartCallBacks: {
        DartCallback(
          name: 'passProofJsonString',
          callBack: (dynamic msg) {
            // TODO(knaoe): verify with REST API
            widget.onVerified?.call();
            return {showAlertDialog(msg.toString(), context)};
          },
        ),
      },
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }
}

void showAlertDialog(String content, BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}

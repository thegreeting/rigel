import 'dart:math';

import 'package:altair/presentation/template/loading.template.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webviewx/webviewx.dart';

class WorldIdPage extends StatelessWidget {
  const WorldIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: rootBundle.loadString('world-id.html'),
        builder: (context, snapshot) => snapshot.hasData
            ? WebViewXPage(initialContent: snapshot.data)
            : const LoadingPage(),
      ),
    );
  }
}

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    super.key,
    this.initialContent,
  });

  final String? initialContent;

  @override
  WebViewXPageState createState() => WebViewXPageState();
}

class WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController<dynamic> webviewController;
  final initialContent = '<h4>Loading Content...<h4>';
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
          callBack: (dynamic msg) => {showAlertDialog(msg.toString(), context)},
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

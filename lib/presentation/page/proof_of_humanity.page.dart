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
        future: rootBundle.loadString('assets/world-id.html'),
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
  final initialContent =
      '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';
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
        title: const Text('WebViewX Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              buildSpace(direction: Axis.vertical, amount: 10, flex: false),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Play around with the buttons below',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              buildSpace(direction: Axis.vertical, amount: 10, flex: false),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                ),
                child: _buildWebViewX(),
              ),
              Expanded(
                child: Scrollbar(
                  child: SizedBox(
                    width: min(screenSize.width * 0.8, 512),
                    child: ListView(
                      children: _buildButtons(),
                    ),
                  ),
                ),
              ),
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
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          js: """
function enableWorldID(signal) { 
  console.log('Your signal ' + signal);
  worldID.init('world-id-container', {
    debug: true, // to aid with debugging, remove in production
    enable_telemetry: true,
    action_id: 'wid_staging_16a48f71d4da3d5afda8350c4d33d148', // obtain this from developer.worldcoin.org
    signal: signal,
    on_success: (verificationResponse) => {
      console.log(JSON.stringify(verificationResponse));
      TestDartCallback(verificationResponse.proof);
    },
    on_error: (error) => TestDartCallback(error),
  })
}
""",
        ),
        EmbeddedJsContent(
          webJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says2: ' + msg) }",
          mobileJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
//         EmbeddedJsContent(js: """
// function enableWorldID(signal) {
//   console.log('your signal', signal);
        // worldID.init('world-id-container', {
        //   debug: true, // to aid with debugging, remove in production
        //   enable_telemetry: true,
        //   action_id: 'wid_staging_16a48f71d4da3d5afda8350c4d33d148', // obtain this from developer.worldcoin.org
        //   signal: signal,
        //   on_success: (proof) => console.log(proof),
        //   on_error: (error) => console.error(error),
        // })
//   try {
//     const result = await worldID.enable(); // <- Send 'result' to your backend or sm
//     console.log("result", result);
//     TestDartCallback(result);
//   } catch (failure) {
//     console.warn("World ID verification failed:", failure);
//     TestDartCallback(failure);
//     // Re-activate here so your end user can try again
//   }
//   TestDartCallback()
// }
// """),
      },
      dartCallBacks: {
        DartCallback(
          name: 'TestDartCallback',
          callBack: (dynamic msg) => showSnackBar(msg.toString(), context),
        ),
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  void _setUrl() {
    webviewController.loadContent(
      'https://flutter.dev',
      SourceType.url,
    );
  }

  void _setUrlBypass() {
    webviewController.loadContent(
      'https://news.ycombinator.com/',
      SourceType.urlBypass,
    );
  }

  void _setHtml() {
    webviewController.loadContent(
      initialContent,
      SourceType.html,
    );
  }

  void _setHtmlFromAssets() {
    webviewController.loadContent(
      'assets/test.html',
      SourceType.html,
      fromAssets: true,
    );
  }

  Future<void> _goForward() async {
    if (await webviewController.canGoForward()) {
      await webviewController.goForward();
      showSnackBar('Did go forward', context);
    } else {
      showSnackBar('Cannot go forward', context);
    }
  }

  Future<void> _goBack() async {
    if (await webviewController.canGoBack()) {
      await webviewController.goBack();
      showSnackBar('Did go back', context);
    } else {
      showSnackBar('Cannot go back', context);
    }
  }

  void _reload() {
    webviewController.reload();
  }

  void _toggleIgnore() {
    final ignoring = webviewController.ignoresAllGestures;
    webviewController.setIgnoreAllGestures(!ignoring);
    showSnackBar('Ignore events = ${!ignoring}', context);
  }

  Future<void> _evalRawJsInGlobalContext() async {
    try {
      final result = await webviewController.evalRawJavascript(
        '2+2',
        inGlobalContext: true,
      ) as String;
      showSnackBar('The result is $result', context);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      showAlertDialog(
        executeJsErrorMessage,
        context,
      );
    }
  }

  Future<void> _callPlatformIndependentJsMethod() async {
    try {
      await webviewController
          .callJsMethod('testPlatformIndependentMethod', <dynamic>[]);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      showAlertDialog(
        executeJsErrorMessage,
        context,
      );
    }
  }

  Future<void> _callPlatformSpecificJsMethod() async {
    try {
      // await webviewController.callJsMethod('testPlatformSpecificMethod', ['Hi']);
      await webviewController.callJsMethod('enableWorldID', <dynamic>['signal']);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      showAlertDialog(
        executeJsErrorMessage,
        context,
      );
    }
  }

  Future<void> _getWebviewContent() async {
    try {
      final content = await webviewController.getContent();
      showAlertDialog(content.source, context);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      showAlertDialog('Failed to execute this task.', context);
    }
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }

  List<Widget> _buildButtons() {
    return [
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Call platform specific Js method, that calls back a Dart function',
        onTap: _callPlatformSpecificJsMethod,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: createButton(onTap: _goBack, text: 'Back')),
          buildSpace(amount: 12, flex: false),
          Expanded(child: createButton(onTap: _goForward, text: 'Forward')),
          buildSpace(amount: 12, flex: false),
          Expanded(child: createButton(onTap: _reload, text: 'Reload')),
        ],
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text:
            'Change content to URL that allows iframes embedding\n(https://flutter.dev)',
        onTap: _setUrl,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text:
            'Change content to URL that doesnt allow iframes embedding\n(https://news.ycombinator.com/)',
        onTap: _setUrlBypass,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Change content to HTML (hardcoded)',
        onTap: _setHtml,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Change content to HTML (from assets)',
        onTap: _setHtmlFromAssets,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Toggle on/off ignore any events (click, scroll etc)',
        onTap: _toggleIgnore,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Evaluate 2+2 in the global "window" (javascript side)',
        onTap: _evalRawJsInGlobalContext,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Call platform independent Js method (console.log)',
        onTap: _callPlatformIndependentJsMethod,
      ),
      buildSpace(direction: Axis.vertical, flex: false, amount: 20),
      createButton(
        text: 'Show current webview content',
        onTap: _getWebviewContent,
      ),
    ];
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

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 1),
      ),
    );
}

Widget createButton({
  VoidCallback? onTap,
  required String text,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    child: Text(text),
  );
}

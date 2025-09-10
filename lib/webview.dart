import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() {
    controller = WebViewController();
    controller.loadRequest(
      Uri.parse(
        "https://dev.marketplace.spaceworx.com/shop-fronts/extra-tqcwlm?countries=SG",
      ),
    );
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onUrlChange: (change) {
          debugPrint("************URL CANGED" + change.url.toString());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          debugPrint("Screen" + didPop.toString());
        } else {
          debugPrint("Screen NOT" + didPop.toString());
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: SafeArea(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController _inAppWebViewController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('web view'),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(),
        initialUrl: "https://www.baidu.com/",
        onWebViewCreated: (controller) {
          _inAppWebViewController = controller;
        },
      ),
    );
  }
}

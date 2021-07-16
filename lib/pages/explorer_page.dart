import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_example/widgets/navigation_control_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExplorerPage extends StatefulWidget {
  ExplorerPage({Key? key}) : super(key: key);

  @override
  _ExplorerPage createState() => _ExplorerPage();
}

class _ExplorerPage extends State<ExplorerPage> {
  Completer<WebViewController> _webViewControllerFuture =
      Completer<WebViewController>();

  String url = 'https://www.google.com';

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        appBar: AppBar(
          title: const Text('Web Explorer'),
          actions: <Widget>[
            NavigationControls(_webViewControllerFuture.future)
          ],
        ),
        body: WebView(
          initialUrl: url,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewControllerFuture.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          userAgent:
              "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36",
        ));
  }
}

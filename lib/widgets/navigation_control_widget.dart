import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _webViewControllerFuture,
        builder:
            (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
          final bool webViewReady =
              snapshot.connectionState == ConnectionState.done;
          if (webViewReady) {
            final WebViewController controller = snapshot.data!;
            return Row(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoBack()) {
                          await controller.goBack();
                        } else {
                          // ignore: deprecated_member_use
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                                content: const Text(
                                    "There are no pages in history")),
                          );
                          return;
                        }
                      },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoForward()) {
                          await controller.goForward();
                        } else {
                          // ignore: deprecated_member_use
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                                content: const Text(
                                    "There are no pages in history")),
                          );
                          return;
                        }
                      },
              ),
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: !webViewReady
                    ? null
                    : () {
                        controller.reload();
                      },
              ),
            ]);
          } else
            return Container();
        });
  }
}

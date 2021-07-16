import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:webview_example/utils/connectivity_checker.dart';

import 'explorer_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  ConnectivityChecker _connectivityChecker = ConnectivityChecker.instance;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    _connectivityChecker.initialise();
    _connectivityChecker.streamStatus.listen((source) {
      if (source) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Conected to internet'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('You don\'t have an internet connection'),
        ));
      }
      setState(() {
        isOnline = source;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOnline
        ? ExplorerPage()
        : Scaffold(
            appBar: AppBar(title: const Text('Web Explorer')),
            backgroundColor: const Color(0xFFF1F1F1),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const Icon(Icons.wifi_off),
                  const Text("Internet connection not found"),
                  ElevatedButton(
                    child: const Text("Check internet connections"),
                    onPressed: () => AppSettings.openWIFISettings(),
                  ),
                ])));
  }

  @override
  void dispose() {
    _connectivityChecker.disposeStream();
    super.dispose();
  }
}

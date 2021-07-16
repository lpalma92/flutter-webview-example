import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityChecker {
  ConnectivityChecker._internal();

  static final ConnectivityChecker _instance = ConnectivityChecker._internal();

  static ConnectivityChecker get instance => _instance;

  StreamController controller = StreamController.broadcast();

  Stream get streamStatus => controller.stream;

  void initialise() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setConnectionResult(result);
    Connectivity().onConnectivityChanged.listen((result) {
      setConnectionResult(result);
    });
  }

  void setConnectionResult(ConnectivityResult result) async {
    bool isOnline = false;
    if (result == ConnectivityResult.none) isOnline = false;
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) isOnline = true;
    controller.sink.add(isOnline);
  }

  void disposeStream() => controller.close();
}

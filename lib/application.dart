import 'package:flutter/material.dart';
import 'package:webview_example/pages/main_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD2FF30),
        accentColor: const Color(0xFFFF9E1B),
      ),
      home: MainPage(),
    );
  }
}

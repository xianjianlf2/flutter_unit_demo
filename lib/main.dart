import 'package:flutter/material.dart';
import 'package:flutter_unit_application/chat_window_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Window',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatWindowPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logoispum/screens/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Logoipsum'),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';

import './splashscreen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Alkitab',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
      
    );
  }
}

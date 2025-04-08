import 'package:flutter/material.dart';
import 'package:marine_ar_explorer/ar_page.dart';

void main() => runApp(const MarineARApp());

class MarineARApp extends StatelessWidget {
  const MarineARApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marine AR Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ARViewPage(),
    );
  }
}

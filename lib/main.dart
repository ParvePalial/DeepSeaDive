import 'package:flutter/material.dart';
import 'package:marine_ar_explorer/ar_page.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

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
      home: kIsWeb || (!Platform.isIOS && !Platform.isAndroid) 
          ? const UnsupportedPlatformScreen() 
          : const ARViewPage(),
    );
  }
}

class UnsupportedPlatformScreen extends StatelessWidget {
  const UnsupportedPlatformScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marine AR Explorer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 80, color: Colors.amber),
              const SizedBox(height: 24),
              const Text(
                'AR Features Unavailable',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This application requires a physical iOS or Android device to use the AR features.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // In a real app, you might provide alternative content here
                },
                child: const Text('View 3D Models in Gallery Mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

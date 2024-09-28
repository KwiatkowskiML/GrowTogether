// main.dart
import 'package:flutter/material.dart';
import 'package:grow_together/widgets/event_popup_card.dart';
import 'package:grow_together/widgets/map.dart';

void main() {
  // runApp(GrowTogetherApp());
  runApp(const TestApp());
}

class GrowTogetherApp extends StatelessWidget {
  const GrowTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EventPopupCard(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps in Flutter'),
      ),
      body: const MapScreen(),
    );
  }
}

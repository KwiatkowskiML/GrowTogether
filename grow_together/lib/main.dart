import 'package:flutter/material.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
import 'package:grow_together/widgets/map.dart';

void main() {
  runApp(GrowTogetherApp());
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

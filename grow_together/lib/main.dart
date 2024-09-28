// main.dart
import 'package:flutter/material.dart';
import 'package:grow_together/widgets/map.dart';

void main() {
  runApp(GrowTogetherApp());
}

class GrowTogetherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps in Flutter'),
      ),
      body: MapScreen(),
    );
  }
}

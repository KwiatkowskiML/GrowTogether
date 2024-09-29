import 'package:flutter/material.dart';
import 'package:grow_together/widgets/add_event_button.dart';
import 'package:grow_together/widgets/floating_search_bar.dart';
import 'package:grow_together/widgets/map.dart';

void main() {
  // runApp(GrowTogetherApp());
  runApp(const GrowTogetherApp());
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
        title: const Text('Grow Together'),
      ),
      body: Stack(
        children: <Widget>[MapScreen(), FloatingSearchBar(), AddEventButton()],
      ),
    );
  }
}

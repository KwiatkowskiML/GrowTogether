import 'package:flutter/material.dart';
import 'package:grow_together/widgets/floating_search_bar.dart';
import 'package:grow_together/widgets/login_widget.dart';
import 'package:grow_together/widgets/map.dart';
import 'package:grow_together/widgets/side_bar.dart';

import 'widgets/auth_widget.dart';

void main() {
  runApp(const GrowTogetherApp());
}

class GrowTogetherApp extends StatelessWidget {
  const GrowTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grow Together',
      theme: ThemeData(
        primarySwatch: Colors.purple,
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
        actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: LoginWidget()),
        ],
      ),
      body: Stack(
        children: <Widget>[MapScreen(), FloatingSearchBar()],
      ),
    );
  }
}

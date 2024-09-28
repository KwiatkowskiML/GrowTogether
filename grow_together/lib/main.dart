import 'package:flutter/material.dart';
import 'package:grow_together/widgets/add_event_button.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
import 'package:grow_together/widgets/floating_search_bar.dart';
import 'package:grow_together/widgets/map.dart';

void main() {
<<<<<<< HEAD
  // runApp(GrowTogetherApp());
  runApp(const GrowTogetherApp());
=======
  runApp(GrowTogetherApp());
>>>>>>> 5005bd0c322c1b52e8d254903e92cef0def24bc8
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
      body: Stack(
        children: <Widget>[
          MapScreen(),
          FloatingSearchBar(),
          AddEventButton()
        ],
      ),
    );
  }
}





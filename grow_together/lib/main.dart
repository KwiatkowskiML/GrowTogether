import 'package:flutter/material.dart';
import 'package:grow_together/widgets/add_event_button.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
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

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Event Popup Test')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: EventPopupCard(
            avatarInitial: 'A',
            eventTitle: 'Charity Run',
            eventOwnerName: 'John Doe',
            eventOwnerEmail: 'john.doe@gmail.com',
            eventDescription:
                'Join us for a charity run to raise funds for cancer research. Every contribution counts!',
            assembledAmount: 1423,
            totalGoalAmount: 2000,
            growersCount: 242,
            benefitsText:
                'You will get a 10% discount on all products. Your contribution helps us make a difference!',
          ),
        ),
      ),
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





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
import 'package:grow_together/widgets/greek_vine_border_card.dart';

void main() {
  runApp(StandaloneTestApp());
}

class StandaloneTestApp extends StatelessWidget {
  const StandaloneTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Popup Card Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Event Popup Card Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GreekVineBorderCard(
                  body: EventPopupCard(
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
              ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

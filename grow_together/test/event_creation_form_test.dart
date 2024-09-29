import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grow_together/widgets/event_creation_form/event_creation_form.dart';

void main() {
  runApp(StandaloneTestApp());
}

class StandaloneTestApp extends StatelessWidget {
  const StandaloneTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: EventCreationForm(
                  eventOwnerId: 1,
                  eventLat: 52.2297,
                  eventLon: 21.0122,
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

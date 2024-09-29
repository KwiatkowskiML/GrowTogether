import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grow_together/widgets/greek_vine_border_card.dart';

void main() {
  runApp(StandaloneTestApp());
}

class StandaloneTestApp extends StatelessWidget {
  const StandaloneTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greek Vine Border Card Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Greek Vine Border Card Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GreekVineBorderCard(
                body: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: const Text('Hello, World!'),
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

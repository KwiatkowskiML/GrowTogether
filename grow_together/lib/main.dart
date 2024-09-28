import 'package:flutter/material.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
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
          // Replace this container with your Map widget
          MapScreen(),
          FloatingSearchBar(),
          AddEventButton()
        ],
      ),
    );
  }
}

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 15,
      left: 15,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              splashColor: Colors.grey,
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            const Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 15,
      left: 15,
      child: Container(
        child: Row(
          children: [
            Container(
                width: 150,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                  ),
                  child: const Text('Add event'),
                  onPressed: () {
                    // Button press logic here
                  },
                ))
          ],
        ),
      ),
    );
  }
}

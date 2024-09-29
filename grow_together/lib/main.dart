import 'package:flutter/material.dart';
import 'package:grow_together/events/eventsList.dart';
import 'package:grow_together/widgets/login_widget.dart';
import 'package:grow_together/widgets/map.dart';
import 'package:grow_together/models/event.dart';

void main() {
  runApp(const GrowTogetherApp());
}

class GrowTogetherApp extends StatelessWidget {
  const GrowTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grow Together app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<MapScreenState> _key = GlobalKey();

  List<Widget> _buildSearchSuggestions(String query) {
    if (query.isEmpty) return [];

    final lowercaseQuery = query.toLowerCase();
    final filteredEvents = eventsList.where((event) =>
        event.eventTitle.toLowerCase().contains(lowercaseQuery)).toList();

    return filteredEvents.map((event) => ListTile(
      title: Text(event.eventTitle),
      subtitle: Text(
        event.eventDesc,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        print('Selected event: ${event.eventTitle}');
        _key.currentState?.updatePosition(event.eventLat, event.eventLon);

      },
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grow Together app'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginWidget(),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          MapScreen(key: _key),
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: SearchAnchor.bar(
              barHintText: 'Search events...',
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                return _buildSearchSuggestions(controller.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
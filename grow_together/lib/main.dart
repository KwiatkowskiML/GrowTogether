import 'package:flutter/material.dart';
import 'package:grow_together/user.dart';
import 'package:grow_together/widgets/floating_search_bar.dart';
import 'package:grow_together/widgets/login_widget.dart';
import 'package:grow_together/widgets/map.dart';
import 'package:grow_together/widgets/side_bar.dart';
import 'package:grow_together/events/eventsList.dart';
import 'package:grow_together/widgets/login_widget.dart';
import 'package:grow_together/widgets/map.dart';
import 'package:grow_together/models/event.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final GlobalKey<MapScreenState> _key = GlobalKey();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _buildSearchSuggestions(
      String query, SearchController controller) {
    if (query.isEmpty) return [];

    final lowercaseQuery = query.toLowerCase();
    final filteredEvents = eventsList
        .where(
            (event) => event.eventTitle.toLowerCase().contains(lowercaseQuery))
        .toList();

    return filteredEvents
        .map((event) => ListTile(
              title: Text(event.eventTitle),
              subtitle: Text(
                event.eventDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () async {
                print('Selected event: ${event.eventTitle}');
                widget._key.currentState
                    ?.updatePosition(event.eventLat, event.eventLon);

                // Close the suggestions view
                controller
                    .closeView(event.eventTitle); // Pass the selected item
                await Future.delayed(Duration(seconds: 1));

                widget._key.currentState?.showPopUp(event);
              },
            ))
        .toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grow Together'),
          actions: [
            Padding(padding: const EdgeInsets.all(8.0), child: LoginWidget()),
          ],
        ),
        body: Stack(
          children: <Widget>[
            MapScreen(key: widget._key),
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: SearchAnchor.bar(
                barHintText: 'Search events...',
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return _buildSearchSuggestions(controller.text, controller);
                },
              ),
            ),
            SideBar()
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grow_together/events/eventsList.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  // Set custom markers on the map
  void _setMarkers() {
    for (var event in eventsList) {
      var marker = Marker(
        markerId: MarkerId(event.eventTitle),
        position: LatLng(event.eventLat, event.eventLon),
        infoWindow: InfoWindow(
          title: event.eventTitle,
          snippet: event.eventDesc,
        ),
        onTap: () {
          // _showCustomPopup();
        },
      );

      
      _markers.add(marker);
    }
  }

  // Show a custom popup or widget
  void _showCustomPopup() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Custom Marker Popup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('This popup appears when you tap on the marker.'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(50.049683, 19.944544),
          zoom: 14,
        ),
        markers: _markers,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    _markers.add(
      Marker(
        markerId: MarkerId('customMarker'),
        position: LatLng(37.42796133580664, -122.085749655962),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure), // You can use custom icons too
        onTap: () {
          _showCustomPopup();
        },
      ),
    );
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
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14,
        ),
        markers: _markers,
      ),
    );
  }
}

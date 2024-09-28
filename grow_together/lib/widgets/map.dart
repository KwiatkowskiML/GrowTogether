import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grow_together/events/eventsList.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    for (var event in eventsList) {
      var marker = Marker(
        markerId: MarkerId(event.eventTitle),
        position: LatLng(event.eventLat, event.eventLon),
        // infoWindow: InfoWindow(
        //   title: event.eventTitle,
        //   snippet: event.eventDesc,
        // ),
        onTap: () {
          _showCustomPopup(event);
        },
      );

      _markers.add(marker);
    }
  }

  // Show a custom popup or widget
  void _showCustomPopup(event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 2,
            child: EventPopupCard(
                avatarInitial: event.eventOwnerName[0],
                eventTitle: event.eventTitle,
                eventOwnerName: event.eventOwnerName,
                eventOwnerEmail: event.eventOwnerContactMail,
                eventDescription: event.eventDesc,
                assembledAmount: event.eventCurrentMoney,
                totalGoalAmount: event.eventGoal,
                growersCount: event.eventContributorsNumber,
                benefitsText: event.eventBenefitDesc),
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grow_together/events/eventsList.dart';
import 'package:grow_together/widgets/event_creation_form/event_creation_form.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
import 'package:grow_together/widgets/greek_vine_border_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = <Marker>{};

  double lat = 50.049683;
  double lon = 19.944544;

  void updatePosition(newLat, newLon) {
    setState(() {
      lat = newLat;
      lon = newLon;
      if (_controller != null){

          _controller!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lon), 14));

      }
    });
  }

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
        onTap: () {
          _showCustomPopup(event);
        },
      );

      _markers.add(marker);
    }
  }

  Future<void> _getVisibleRegion() async {
    if (_controller != null) {
      LatLngBounds bounds = await _controller!.getVisibleRegion();
      _filterEventsByViewport(bounds);
    }
  }

  void _filterEventsByViewport(LatLngBounds bounds) {
    setState(() {
      _markers.clear();
      for (var event in eventsList) {
        if (_isInBounds(bounds, LatLng(event.eventLat, event.eventLon))) {
          var marker = Marker(
            markerId: MarkerId(event.eventTitle),
            position: LatLng(event.eventLat, event.eventLon),
            onTap: () {
              _showCustomPopup(event);
            },
          );
          _markers.add(marker);
        }
      }
    });
  }

  bool _isInBounds(LatLngBounds bounds, LatLng position) {
    return position.latitude >= bounds.southwest.latitude &&
        position.latitude <= bounds.northeast.latitude &&
        position.longitude >= bounds.southwest.longitude &&
        position.longitude <= bounds.northeast.longitude;
  }

  void _showCustomPopup(event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final mediaQuery = MediaQuery.of(context);
              final screenWidth = mediaQuery.size.width;
              final screenHeight = mediaQuery.size.height;

              bool isSmall = screenWidth < 1200;

              double maxWidth = screenWidth * 2.3 / 3;
              double maxHeight = screenHeight * 2.3 / 3;

              Widget content = ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                  maxHeight: maxHeight,
                ),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: EventPopupCard(
                    avatarInitial: event.eventOwnerName[0],
                    eventTitle: event.eventTitle,
                    eventOwnerName: event.eventOwnerName,
                    eventOwnerEmail: event.eventOwnerContactMail,
                    eventDescription: event.eventDesc,
                    assembledAmount: event.eventCurrentMoney,
                    totalGoalAmount: event.eventGoal,
                    growersCount: event.eventContributorsNumber,
                    benefitsText: event.eventBenefitDesc,
                  ),
                ),
              );

              if (isSmall) {
                return GreekVineBorderCard(body: content);
              } else {
                return content;
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    print(lat);
    print(lon);
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          _getVisibleRegion();
        },
        onCameraIdle: () {
          _getVisibleRegion();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lon),
          zoom: 14,
        ),
        markers: _markers,
      ),
    );
  }
}

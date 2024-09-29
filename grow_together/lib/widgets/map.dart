import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grow_together/events/eventsList.dart';
import 'package:grow_together/widgets/event_creation_form/event_creation_form.dart';
import 'package:grow_together/widgets/event_popup_card/event_popup_card.dart';
import 'package:grow_together/widgets/greek_vine_border_card.dart';

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
        onLongPress: (LatLng latLng) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                        body: EventCreationForm(
                          eventLat: latLng.latitude,
                          eventLon: latLng.longitude,
                          eventOwnerId: 1, // TODO: Replace with actual user ID
                        ),
                      ))).then((value) {
            setState(() {
              _markers.clear();
              _setMarkers();
            });
          });
        },
      ),
    );
  }
}

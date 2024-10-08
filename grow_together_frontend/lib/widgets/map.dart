import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grow_together/conn/api_calls.dart';
import 'package:grow_together/user.dart';
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
      if (_controller != null) {
        _controller!
            .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lon), 14));
      }
    });
  }

  void showPopUp(event) {
    setState(() {
      _showCustomPopup(event);
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() async {
    var events = await ApiCalls.getEvents();
    for (var event in events) {
      var marker = Marker(
        markerId: MarkerId(event.eventTitle),
        position: LatLng(event.eventLat, event.eventLon),
        onTap: () {
          setState(() {
            _markers.clear();
            _setMarkers();
          });
          _showCustomPopup(
            event,
            setState: () {
              _markers.clear();
              _setMarkers();
            },
          );
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

  void _filterEventsByViewport(LatLngBounds bounds) async {
    setState(() {
      // _markers.clear();
      // var events = await ApiCalls.getEvents();
      // for (var event in events) {
      //   if (_isInBounds(bounds, LatLng(event.eventLat, event.eventLon))) {
      //     var marker = Marker(
      //       markerId: MarkerId(event.eventTitle),
      //       position: LatLng(event.eventLat, event.eventLon),
      //       onTap: () {
      //         _showCustomPopup(event);
      //       },
      //     );
      //     _markers.add(marker);
      //   }
      // }
    });
  }

  bool _isInBounds(LatLngBounds bounds, LatLng position) {
    return position.latitude >= bounds.southwest.latitude &&
        position.latitude <= bounds.northeast.latitude &&
        position.longitude >= bounds.southwest.longitude &&
        position.longitude <= bounds.northeast.longitude;
  }

  void _showCustomPopup(event, {Function? setState}) {
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

              bool isSmall = true;

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
                    growersCount: event.eventContributionsNumber,
                    benefitsText: event.eventBenefitDesc,
                    payCallback: setState,
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
          _getVisibleRegion();
        },
        onCameraIdle: () {
          _getVisibleRegion();
        },
        onLongPress: (LatLng latLng) {
          if (!UserSingleton().isLogged()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You need to be logged in to create an event'),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventCreationForm(
                eventLat: latLng.latitude,
                eventLon: latLng.longitude,
                eventOwnerId: 1,
                onEventCreated: () {
                  setState(() {
                    _markers.clear();
                    _setMarkers();
                  });
                },
              ),
            ),
          );
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

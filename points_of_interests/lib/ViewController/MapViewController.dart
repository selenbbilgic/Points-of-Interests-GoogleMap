import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:points_of_interests/model/bar.dart';
import 'package:points_of_interests/model/map_marker.dart';
import 'package:points_of_interests/service/bars_service.dart';
import '/app/extension/context_extension.dart';

class MapViewController {
  late GoogleMapController mapController;
  static const LatLng pGooglePlex = LatLng(37, -122); //default coordinates
  LatLng center = pGooglePlex;
  List<Bar> bars = [];
  List<MapMarker> mapMarkers = [];
  bool isLoading = false;

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  // Accept BuildContext to apply map style
  Future<void> setMapStyle(BuildContext context) async {
    mapController.setMapStyle(context.googleMapStyle);
  }

  void getUserLocation(Function onLocationFetched) async {
    isLoading = true;
    bool serviceEnabled;
    LocationPermission permission;
    Position _currentPosition;

// Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

// Request permission to get the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

// Get the current location of the user
    try {
      _currentPosition = await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting location: $e');
      return;
    }

    //center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    center = LatLng(40.983235, 29.025656);

    mapMarkers.add(
      MapMarker(
        id: 'user_location',
        name: 'Your Location',
        location: center,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), // Custom marker for user
      ),
    );

    onLocationFetched();

    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(center.latitude, center.longitude),
      zoom: 11,
    )));

    isLoading = false;
  }

//get the nearby bars
  Future<void> getNearbyBars(Function onBarsFetched) async {
    //isLoading = true;
    bars = await fetchNearbyBars(center);
    mapMarkers.addAll(bars.map((bar) {
      return MapMarker(
        id: '${bar.name}-${bar.latitude}-${bar.longitude}',
        name: bar.name,
        location: LatLng(bar.latitude, bar.longitude),
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toList());

    print(mapMarkers[1].id.toString() +
        mapMarkers[2].id +
        mapMarkers[19].id.toString());
    onBarsFetched();
    //isLoading = false;
  }
}

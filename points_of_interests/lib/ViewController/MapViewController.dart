import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewController {
  late GoogleMapController mapController;
  static const LatLng pGooglePlex = LatLng(37, -122);
  Position? _currentPosition;
  LatLng center = pGooglePlex;

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void zoomIn() {
    mapController
        .animateCamera(CameraUpdate.zoomIn()); // Use '!' since it's nullable
  }

  void zoomOut() {
    mapController
        .animateCamera(CameraUpdate.zoomOut()); // Use '!' since it's nullable
  }

  void getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

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
    _currentPosition = await Geolocator.getCurrentPosition();
    center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: center!, zoom: 14.0),
      ),
    );
  }
}

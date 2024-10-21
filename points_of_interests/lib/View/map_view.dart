import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/ViewController/MapViewController.dart';
import 'package:geolocator/geolocator.dart';

class Map_View extends StatefulWidget {
  const Map_View({super.key});

  @override
  State<Map_View> createState() => _Map_ViewState();
}

class _Map_ViewState extends State<Map_View> {
  @override
  void initState() {
    _mapViewController.getUserLocation();
    super.initState();
  }

  final MapViewController _mapViewController = MapViewController();

  void _onMapCreated(GoogleMapController controller) {
    _mapViewController.setMapController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _mapViewController.center,
              zoom: 14.0,
            ),
            zoomGesturesEnabled: true,
            markers: {
              Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _mapViewController.center)
            },
          ),
          Positioned(
            top: 40,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _mapViewController.zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _mapViewController.zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

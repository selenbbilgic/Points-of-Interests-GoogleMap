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
    super.initState();
  }

  final MapViewController _mapViewController = MapViewController();

  void _onMapCreated(GoogleMapController controller) {
    _mapViewController.setMapController(controller);
    _mapViewController.setMapStyle(context);
    _mapViewController.getUserLocation(() {
      _mapViewController.getNearbyBars(() {
        setState(() {});
      });
    });

    // _mapViewController.getNearbyBars(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mapViewController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _mapViewController.center,
                    zoom: 14.0,
                  ),
                  zoomGesturesEnabled: true,
                  markers: _mapViewController.mapMarkers.map((marker) {
                    return marker.toMarker(
                      infoWindow: InfoWindow(title: marker.name),
                      onTap: () {
                        // Handle marker tap
                        print("Marker tapped: ${marker.name}");
                      },
                    );
                  }).toSet(),
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
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        onPressed: () {
                          _mapViewController.getUserLocation(() {
                            setState(() {});
                          });
                        },
                        child: const Icon(Icons.place),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

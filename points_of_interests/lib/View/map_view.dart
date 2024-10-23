import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:points_of_interests/app/extension/context_extension.dart';
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
        setState(() {}); // Update the UI after fetching the bars
      });
    });
  }

  void _searchHere() async {
    _mapViewController.getCurrentPOIs(() {
      // Now that the center has been updated, fetch the new POIs
      _mapViewController.getNearbyBars(() {
        setState(() {}); // Update the UI after fetching the new bars
      });
    });
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
                    zoom: 15.0,
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
                  myLocationButtonEnabled: false,
                ),
                Positioned(
                  bottom: 40,
                  left: 10,
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
                            _mapViewController.getNearbyBars(() {
                              setState(
                                  () {}); // Update the UI after fetching the bars
                            });
                          });
                        },
                        child: const Icon(Icons.place),
                      ),
                    ],
                  ),
                ),
                Container(
                    //decoration: BoxDecoration(color: context.secondaryColor),
                    padding: context.paddingP60,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              context.secondaryColor, // Button background color
                          foregroundColor: context.whiteColor, // Text color
                        ),
                        onPressed: _searchHere,
                        child: const Text('Search Here'),
                      ),
                    )),
              ],
            ),
    );
  }
}

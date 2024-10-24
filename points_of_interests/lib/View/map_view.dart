import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:points_of_interests/View/bar_details_view.dart';
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
        setState(() {}); // Update UI after fetching the bars
      });
    });
  }

  void _searchHere() async {
    _mapViewController.getCurrentPOIs(() {
      // Now, the center has been updated, fetch the new POIs
      _mapViewController.getNearbyBars(() {
        setState(() {}); // Update UI after fetching the new bars
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
                  // Map initialization
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _mapViewController.center,
                    zoom: 15.0,
                  ),
                  zoomGesturesEnabled: true,
                  markers: _mapViewController.mapMarkers.map((marker) {
                    // Markers that are stored in the ViewModel
                    return marker.toMarker(
                      onTap: () async {
                        marker.id !=
                                "user_location" // Don't show details for the users current location
                            // Handle marker tap
                            // The pop up screen to display the map details
                            ? await showModalBottomSheet(
                                context: context,
                                backgroundColor: context.whiteColor,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BarDetailsView(
                                    marker: marker,
                                  );
                                },
                              )
                            : null;
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
                      // Zoom In
                      FloatingActionButton(
                        focusColor: context.secondaryColor,
                        backgroundColor: context.primaryColor,
                        onPressed: _mapViewController.zoomIn,
                        child: const Icon(Icons.zoom_in),
                      ),
                      const SizedBox(height: 10),
                      // Zoom out
                      FloatingActionButton(
                        focusColor: context.secondaryColor,
                        backgroundColor: context.primaryColor,
                        onPressed: _mapViewController.zoomOut,
                        child: const Icon(Icons.zoom_out),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        // Center the map back to the user's current location.
                        focusColor: context.secondaryColor,
                        backgroundColor: context.primaryColor,
                        onPressed: () {
                          _mapViewController.getUserLocation(() {
                            _mapViewController.getNearbyBars(() {
                              setState(() {});
                            });
                          });
                        },
                        child: const Icon(Icons.place),
                      ),
                    ],
                  ),
                ),

                // Search here button implementation
                Container(
                    padding: context.paddingP60,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.secondaryColor,
                          foregroundColor: context.whiteColor,
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

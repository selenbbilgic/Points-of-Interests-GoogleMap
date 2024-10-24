// ignore_for_file: avoid_unused_constructor_parameters, use_super_parameters

import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker {
  // Marker class to store different type of pointers.
  MapMarker({
    required this.id,
    required this.name,
    required this.location,
    required this.icon,
  });

  final String id;
  final String name;
  final LatLng location;
  final BitmapDescriptor icon;

  // copy with
  MapMarker copyWith({
    String? id,
    String? name,
    LatLng? location,
    BitmapDescriptor? icon,
  }) {
    return MapMarker(
      id: id ?? this.id,
      name: name ?? this.name,
      location: this.location,
      icon: icon ?? this.icon,
    );
  }

  Marker toMarker({required VoidCallback onTap}) {
    // Convert MapMarker object to Marker
    return Marker(
      markerId: MarkerId(id),
      onTap: onTap,
      infoWindow: id == "user_location" // show info window if user's location
          ? const InfoWindow(
              title: "This is you!",
            )
          : const InfoWindow(),
      position: LatLng(
        location.latitude,
        location.longitude,
      ),
      icon: icon,
    );
  }
}

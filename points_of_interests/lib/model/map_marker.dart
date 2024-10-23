// ignore_for_file: avoid_unused_constructor_parameters, use_super_parameters

import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker {
  MapMarker({
    required this.id,
    required this.name,
    required this.location,
    required this.icon,
    int? clusterId,
    int? pointsSize,
    String? childMarkerId,
  });

  final String id;
  final String name;
  final LatLng location;
  final BitmapDescriptor icon;

  // copy with
  MapMarker copyWith({
    String? id,
    String? name,
    LatLng? position,
    BitmapDescriptor? icon,
  }) {
    return MapMarker(
      id: id ?? this.id,
      name: name ?? this.name,
      location: position ?? this.location,
      icon: icon ?? this.icon,
    );
  }

  Marker toMarker(
      {required InfoWindow? infoWindow, required VoidCallback onTap}) {
    return Marker(
      markerId: MarkerId(id),
      infoWindow: infoWindow ?? InfoWindow.noText,
      onTap: onTap,
      position: LatLng(
        location.latitude,
        location.longitude,
      ),
      icon: icon,
    );
  }
}

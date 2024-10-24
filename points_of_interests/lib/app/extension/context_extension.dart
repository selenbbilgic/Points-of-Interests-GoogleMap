import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;
  TextStyle get _defaultTextStyle => const TextStyle();

  // app colors
  Color get primaryColor => const Color.fromARGB(255, 201, 227, 254);
  Color get secondaryColor => const Color.fromARGB(255, 29, 100, 176);
  Color get whiteColor => const Color.fromARGB(255, 255, 255, 255);
  Color get blackColor => const Color.fromARGB(255, 0, 0, 0);

  // Padding
  EdgeInsets get paddingP10 => const EdgeInsets.all(10);
  EdgeInsets get paddingP60 => const EdgeInsets.all(60);

  // sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // Texts
  TextStyle get headlineSmall => _textTheme.headlineSmall ?? _defaultTextStyle;
  TextStyle get headlineMedium =>
      _textTheme.headlineMedium ?? _defaultTextStyle;
  TextStyle get headlineLarge => _textTheme.headlineLarge ?? _defaultTextStyle;

  // Radius
  BorderRadius get borderRadius15 =>
      const BorderRadius.all(Radius.circular(15));

  // Shadow
  BoxShadow get boxShadowLight => BoxShadow(
        color: blackColor.withOpacity(0.25),
        offset: const Offset(2, 2),
        blurRadius: 4,
        spreadRadius: 1,
      );

  // Google Maps
  String get googleMapStyle => '''
[
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
''';
}

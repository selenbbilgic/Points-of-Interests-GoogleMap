import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:points_of_interests/model/bar.dart';
import 'dart:convert';

Future<List<Bar>> fetchNearbyBars(LatLng center) async {
  const String apiKey = "AIzaSyCwJNQfvDwBJBTtCOkMT6XfKo-0-8bnJ5o";
  final String url =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${center.latitude},${center.longitude}'
      '&radius=1000'
      '&type=bar'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    print(results.map((result) => Bar.fromJson(result)).toList());
    return results.map((result) => Bar.fromJson(result)).toList();
  } else {
    throw Exception('Failed to load nearby restaurants');
  }
}

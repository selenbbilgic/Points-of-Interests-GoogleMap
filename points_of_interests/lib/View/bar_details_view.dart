import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:points_of_interests/app/extension/context_extension.dart';
import 'package:points_of_interests/model/map_marker.dart';

class BarDetailsView extends StatefulWidget {
  const BarDetailsView({required this.marker, super.key});

  final MapMarker marker;

  @override
  State<BarDetailsView> createState() => _BarDetailsViewState();
}

// The pop up screen to display the map details

class _BarDetailsViewState extends State<BarDetailsView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width,
        height: context.height / 1.2,
        child: Container(
            color: context.primaryColor,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Bar name
                Text(
                  widget.marker.name,
                  style: context.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Placeholder Image
                Image.asset(
                  'assets/placeholderImage.png',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Bar Location (latitude and longtitude)
                Container(
                    width: context.width * 0.95,
                    padding: context.paddingP10,
                    decoration: BoxDecoration(
                        color: context.whiteColor,
                        boxShadow: [context.boxShadowLight],
                        borderRadius: context.borderRadius15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "latitude: ${widget.marker.location.latitude}",
                            style: context.headlineSmall,
                          ),
                          Text(
                              "longtitude: ${widget.marker.location.longitude}",
                              style: context.headlineSmall),
                        ])),
              ],
            )));
  }
}

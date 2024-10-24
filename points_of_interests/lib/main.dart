import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:points_of_interests/View/map_view.dart';
import 'package:points_of_interests/app/extension/context_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Google Maps Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: context.primaryColor),
          useMaterial3: true,
        ),
        home: Map_View());
  }
}

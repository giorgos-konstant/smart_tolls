import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(38.24711982918365, 21.735133678871826);
  final String _mapStyleString = '''
[
    {
      "featureType": "poi",
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
  ]''';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 12.0),
          style: _mapStyleString,
        ));
  }
}

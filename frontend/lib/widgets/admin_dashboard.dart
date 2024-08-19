import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

// ignore: must_be_immutable
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

  void showInfo() {
    print('showing info from toll station');
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
            style: _mapStyleString,
            markers: {
              Marker(
                  markerId: MarkerId('Former TEI'),
                  position: LatLng(38.219161, 21.741320),
                  infoWindow: InfoWindow(
                      title:
                          "Former TEI\nZone A\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Rio"),
                  position: LatLng(38.27060317727781, 21.75716703731047),
                  infoWindow: InfoWindow(title: "Rio\nZone A\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Akti Dymaion"),
                  position: LatLng(38.22412037147598, 21.721610010209183),
                  infoWindow: InfoWindow(
                      title:
                          "Akti Dymaion\nZone A\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Perivola"),
                  position: LatLng(38.21281525203603, 21.757070609420534),
                  infoWindow: InfoWindow(
                      title:
                          "Perivola\nZone A\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Konstantinoupoleos"),
                  position: LatLng(38.255407720401685, 21.74355054644139),
                  infoWindow: InfoWindow(
                      title:
                          "Konstantinoupoleos\nZone B\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Othonos Amalias"),
                  position: LatLng(38.24620574583648, 21.73017024635936),
                  infoWindow: InfoWindow(
                      title:
                          "Othonos Amalias\nZone B\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Germanou"),
                  position: LatLng(38.24218439703755, 21.744167021280408),
                  infoWindow: InfoWindow(
                      title:
                          "Germanou\nZone B\nTotal Transactions: 50\nTotal Value: 50 Euros")),
              Marker(
                  markerId: MarkerId("Agiou Andreou"),
                  position: LatLng(38.24561592510374, 21.730846163051964),
                  infoWindow: InfoWindow(
                      title:
                          "Agiou Andreou\nZone B\nTotal Transactions: 50\nTotal Value: 50 Euros")),
            }));
  }
}

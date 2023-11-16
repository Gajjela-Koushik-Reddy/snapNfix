import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DamageLocationView extends StatefulWidget {
  const DamageLocationView({super.key});

  @override
  State<DamageLocationView> createState() => _DamageLocationViewState();
}

class _DamageLocationViewState extends State<DamageLocationView> {
  late GoogleMapController mapController;
    final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ));
  }
}

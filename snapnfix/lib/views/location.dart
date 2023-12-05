import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_storage.dart';

class DamageLocationView extends StatefulWidget {
  DamageLocationView(
      {super.key, required this.userCredential, required this.userPos});

  final DamageReportStorage damageReportStorage = DamageReportStorage();
  final GoogleSignInAccount userCredential;
  final Position userPos;

  @override
  State<DamageLocationView> createState() => _DamageLocationViewState();
}

class _DamageLocationViewState extends State<DamageLocationView> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final allDamages = await widget.damageReportStorage
        .readDamageReport(widget.userCredential.id);
    mapController = controller;

    setState(() {
      _markers.clear();
      for (final damage in allDamages) {
        final marker = Marker(
          markerId: MarkerId(damage["data"]["Title"]),
          position: LatLng(damage["data"]["Location"]["latitude"],
              damage["data"]["Location"]["longitude"]),
          infoWindow: InfoWindow(
              title: damage["data"]["Title"], snippet: damage["data"]["Notes"]),
        );

        _markers[damage["data"]["Title"]] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.userPos.latitude, widget.userPos.longitude),
            zoom: 14),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

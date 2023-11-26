import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

class DamageReportViewer extends StatefulWidget {
  const DamageReportViewer({
    super.key,
    required this.damageRating,
    required this.damagePosition,
    required this.notes,
    required this.title,
    required this.imageURL,
    required this.moreLocation,
  });

  final String damageRating;
  final LatLng damagePosition;
  final String notes;
  final String title;
  final String imageURL;
  final String moreLocation;

  @override
  State<DamageReportViewer> createState() => _DamageReportViewerState();
}

class _DamageReportViewerState extends State<DamageReportViewer> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget buildDamageRating(int rating) {
    return Row(
      children: [
        Icon(Icons.star, color: rating >= 1 ? Colors.orange : Colors.grey),
        Icon(Icons.star, color: rating >= 2 ? Colors.orange : Colors.grey),
        Icon(Icons.star, color: rating >= 3 ? Colors.orange : Colors.grey),
        Icon(Icons.star, color: rating >= 4 ? Colors.orange : Colors.grey),
        Icon(Icons.star, color: rating >= 5 ? Colors.orange : Colors.grey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Damage Report View")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            subtitle: Image.network(widget.imageURL),
          ),
          ListTile(
            title: const Text('Title'),
            subtitle: Text(widget.title),
          ),
          if (widget.notes.isNotEmpty)
            ListTile(
              title: const Text('Notes'),
              subtitle: Text(widget.notes),
            ),
          if (widget.notes.isEmpty)
            const ListTile(
              title: Text('Notes'),
              subtitle: Text("NA"),
            ),
          ListTile(
            title: const Text('Damage Rating'),
            subtitle: buildDamageRating(int.parse(widget.damageRating)),
          ),
          ListTile(
              title: const Text('Location'),
              subtitle: SizedBox(
                height: 150,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: widget.damagePosition,
                    zoom: 15.0,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId(widget.title),
                      position: widget.damagePosition,
                      infoWindow: InfoWindow(title: widget.title),
                    ),
                  },
                ),
              )),
          ListTile(
            title: const Text('Location info'),
            subtitle: Text(widget.moreLocation),
          ),
        ],
      ),
    );
  }
}

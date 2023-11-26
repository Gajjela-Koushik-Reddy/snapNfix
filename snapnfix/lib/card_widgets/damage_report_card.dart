import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_viewer.dart';

class DamageReportCard extends StatefulWidget {
  const DamageReportCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.damageRating,
      required this.damagePosition,
      required this.notes,
      required this.moreLocation});

  final String damageRating;
  final LatLng damagePosition;
  final String notes;
  final String title;
  final String imageUrl;
  final String moreLocation;

  @override
  State<DamageReportCard> createState() => _DamageReportCardState();
}

class _DamageReportCardState extends State<DamageReportCard> {
  bool toggleButton = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.deepPurpleAccent)),
          dense: false,
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            backgroundImage: widget.imageUrl.isNotEmpty
                ? NetworkImage(widget.imageUrl)
                : null,
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Colors.deepPurpleAccent, width: 2)),
              ),
            ),
          ),
          title: Text(widget.title),
          trailing: Checkbox(
            onChanged: (value) {
              setState(() {
                toggleButton = !toggleButton;
              });
            },
            value: toggleButton,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DamageReportViewer(
                      damageRating: widget.damageRating,
                      notes: widget.notes,
                      title: widget.title,
                      imageURL: widget.imageUrl,
                      moreLocation: widget.moreLocation,
                      damagePosition: widget.damagePosition,
                    )));
          },
        ),
      ],
    );
  }
}

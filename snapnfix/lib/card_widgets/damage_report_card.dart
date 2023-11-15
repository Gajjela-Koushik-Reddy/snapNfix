import 'package:flutter/material.dart';

class DamageReportCard extends StatefulWidget {
  const DamageReportCard(
      {super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

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
            backgroundImage: NetworkImage(widget.imageUrl),
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
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DamageReportCard extends StatefulWidget {
  const DamageReportCard({super.key, required this.title});

  final String title;

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
          leading: const Icon(
            Icons.image,
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

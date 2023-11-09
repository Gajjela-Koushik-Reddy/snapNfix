import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DamageReportCard extends StatefulWidget {
  const DamageReportCard({super.key});

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
              side: BorderSide(color: Colors.redAccent)),
          dense: false,
          subtitle: const Text("#23"),
          leading: const Icon(Icons.image),
          title:
              const Text("Exploring the universe's mysteries fuels our quest."),
          trailing: Checkbox(
            onChanged: (value) {
              setState(() {
                if (kDebugMode) {
                  print("before toggleButton: $toggleButton");
                }
                toggleButton = !toggleButton;
                if (kDebugMode) {
                  print("after toggleButton: $toggleButton");
                }
              });
            },
            value: toggleButton,
          ),
          // tileColor: Colors.red,
        ),
      ],
    );
  }
}

import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/views/DamageReporting/damageReport.dart';
// import 'package:geolocator/geolocator.dart';

class NextView extends StatefulWidget {
  const NextView({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<NextView> createState() => _NextViewState();
}

class _NextViewState extends State<NextView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Damage')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath)),
      floatingActionButton: ElevatedButton(
        onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const DamageReportView()));

        },
        child: const SizedBox(
            width: 75,
            height: 40,
            child: Center(
              child: Text("Next"),
            )),
      ),
    );
  }
}

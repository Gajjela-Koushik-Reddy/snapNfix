import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapnfix/views/DamageReporting/damageReport.dart';

class NextView extends StatefulWidget {
  const NextView({super.key, required this.imagePath, required this.userCredential});

  final String imagePath;
  final GoogleSignInAccount userCredential;

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
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DamageReportView(
                    imagePath: widget.imagePath,
                    userCredential: widget.userCredential,
                  )));
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

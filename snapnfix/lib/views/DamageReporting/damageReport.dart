import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DamageReportView extends StatefulWidget {
  const DamageReportView({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<DamageReportView> createState() => _DamageReportViewState();
}

class _DamageReportViewState extends State<DamageReportView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  late int _rating;
  late Future<Position> _position;

  // Initializing Colors for Damage Rating
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;

  Widget buildDamageRating() {
    return Row(
      children: [
        IconButton(
          onPressed: () => setState(() {
            _myColorOne = Colors.orange;
            _myColorTwo = Colors.grey;
            _myColorThree = Colors.grey;
            _myColorFour = Colors.grey;
            _myColorFive = Colors.grey;
            _rating = 1;
          }),
          icon: const Icon(Icons.star),
          color: _myColorOne,
        ),
        IconButton(
          onPressed: () => setState(() {
            _myColorOne = Colors.orange;
            _myColorTwo = Colors.orange;
            _myColorThree = Colors.grey;
            _myColorFour = Colors.grey;
            _myColorFive = Colors.grey;
            _rating = 2;
          }),
          icon: const Icon(Icons.star),
          color: _myColorTwo,
        ),
        IconButton(
            onPressed: () => setState(() {
                  _myColorOne = Colors.orange;
                  _myColorTwo = Colors.orange;
                  _myColorThree = Colors.orange;
                  _myColorFour = Colors.grey;
                  _myColorFive = Colors.grey;
                  _rating = 3;
                }),
            icon: const Icon(Icons.star),
            color: _myColorThree),
        IconButton(
          onPressed: () => setState(() {
            _myColorOne = Colors.orange;
            _myColorTwo = Colors.orange;
            _myColorThree = Colors.orange;
            _myColorFour = Colors.orange;
            _myColorFive = Colors.grey;
            _rating = 4;
          }),
          icon: const Icon(Icons.star),
          color: _myColorFour,
        ),
        IconButton(
          onPressed: () => setState(() {
            _myColorOne = Colors.orange;
            _myColorTwo = Colors.orange;
            _myColorThree = Colors.orange;
            _myColorFour = Colors.orange;
            _myColorFive = Colors.orange;
            _rating = 5;
          }),
          icon: const Icon(Icons.star),
          color: _myColorFive,
        ),
      ],
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_titleLength);
    _position = _determinePosition();
  }

  int _titleLength() {
    final text = _titleController.text;

    if (kDebugMode) {
      print(text.characters.length);
    }

    return text.characters.length;
  }

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    return Scaffold(
        appBar: AppBar(
          title: const Text("Damage Report"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      // height: 250,
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.95,
                      // child: Image.network("https://picsum.photos/250?image=9"),
                      child: Image.file(File(widget.imagePath)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: FutureBuilder(
                          future: _position,
                          builder: (context, snapshot) {
                            List<Widget> children;
                            if (snapshot.hasData) {
                            //   return Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       const Icon(Icons.location_on),
                            //       Text("${snapshot.data}")
                            //     ],
                            //   );
                              children = <Widget>[
                                Text(
                                    "(${snapshot.data?.latitude}, ${snapshot.data?.longitude})"),
                              ];
                            } else if (snapshot.hasError) {
                              // return const Row(
                              //   children: [
                              //     Icon(Icons.location_on),
                              //     Text("Location Unavailable"),
                              //   ],
                              // );
                              children = <Widget>[
                                const Text("Location Unavailable"),
                              ];
                            } else {
                              // return const SizedBox(
                              //     width: 15,
                              //     height: 15,
                              //     child: Row(
                              //       children: [
                              //         Icon(Icons.location_on),
                              //         CircularProgressIndicator(),
                              //       ],
                              //     ));

                              children = <Widget>[
                                const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(),
                                ),
                              ];
                            }
                            // Adding Location icon to the front of the Icon list
                            children.insert(0, const Icon(Icons.location_on));
                            return Row(
                              children: children,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 380,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        // width: 380,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Location',
                              hintText: 'Room No, Floor, Landmark., etc.'),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      // width: 380,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Damage Rating"),
                          buildDamageRating(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      // width: 380,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Notes',
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print("Location: $_position");
                            print("Title: ${_titleController.text}");
                            print("This is the star rating $_rating");
                          }
                        },
                        child: const Text("Submit"))
                  ],
                )),
            // );,
          ),
        ));
  }
}

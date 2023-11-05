import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DamageReportView extends StatefulWidget {
  const DamageReportView({super.key});

  @override
  State<DamageReportView> createState() => _DamageReportViewState();
}

class _DamageReportViewState extends State<DamageReportView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  late int _rating;

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

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_titleLength);
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
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 250,
                width: 380,
                child: Image.network("https://picsum.photos/250?image=9"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380,
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
                  width: 380,
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
                width: 380,
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
                width: 380,
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
                      print("This is the star rating $_rating");
                    }
                  },
                  child: const Text("Submit"))
            ],
          )),
    );
  }
}

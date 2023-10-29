import 'package:flutter/material.dart';
import 'package:snapnfix/views/camera.dart';
import 'package:snapnfix/views/list.dart';
import 'package:snapnfix/views/location.dart';
import 'package:snapnfix/views/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildBottomNavigation() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.location_pin,
              color: Colors.black,
            ),
            label: "Location"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera_front_sharp,
              color: Colors.black,
            ),
            label: "Camera"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            label: "Damages"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            label: "Profile"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  static const List<Widget> allViews = [
    DamageLocationView(),
    CameraView(),
    DamageListView(),
    UserProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SnapNFix")),
      ),
      body: allViews.elementAt(_selectedIndex),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
}

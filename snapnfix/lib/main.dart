import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/views/DamageReporting/camera.dart';
// import 'package:snapnfix/views/DamageReporting/camera.dart';
// import 'package:snapnfix/views/DamageReporting/damageReport.dart';
import 'package:snapnfix/views/list.dart';
import 'package:snapnfix/views/location.dart';
import 'package:snapnfix/views/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        camera: camera,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(_selectedIndex);
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

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        _onItemTapped(index);
      },
      children: [
        const DamageLocationView(),
        CameraView(
          camera: widget.camera,
        ),
        // DamageReportView(),
        DamageListView(),
        const UserProfileView()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SnapNFix")),
      ),
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
}

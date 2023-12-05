import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapnfix/authentication/login.dart';
import 'package:snapnfix/firebase_options.dart';
import 'package:snapnfix/views/DamageReporting/camera.dart';
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
  bool _initialized = false;
  bool _showMainPage = false;
  int _selectedIndex = 1;
  GoogleSignInAccount? _googleUser;
  PageController pageController = PageController(
    initialPage: 1,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(_selectedIndex);
    });
  }

  void _setShowMainPage() {
    setState(() {
      _showMainPage = true;
    });
  }

  void _setShowLoginPage() {
    setState(() {
      _showMainPage = false;
    });
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default Firebase app $app");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Trigger the authentication flow
    _googleUser = await GoogleSignIn().signIn();

    if (kDebugMode) {
      print(_googleUser!.displayName);
    }

    // after logging in change the view
    _setShowMainPage();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await _googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DamageLocationView(userCredential: _googleUser!),
        CameraView(
          camera: widget.camera,
          userCredential: _googleUser!,
        ),
        DamageListView(userCredential: _googleUser!),
        UserProfileView(
          onLogoutSuccess: _setShowLoginPage,
          userCredential: _googleUser!,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showMainPage) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("SnapNFix")),
        ),
        body: buildPageView(),
        bottomNavigationBar: buildBottomNavigation(),
      );
    } else {
      return LoginView(
        onLoginSuccess: _setShowMainPage,
        signInFunction: signInWithGoogle,
      );
    }
  }
}

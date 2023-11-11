import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/views/DamageReporting/next.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder<void>(
              future: _initializeCameraControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
        Positioned(
          bottom: 10,
          child: Row(
            children: [
              IconButton(
                iconSize: 100,
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeCameraControllerFuture;
                    // final Position position = await _determinePosition();

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await _cameraController.takePicture();

                    if (!mounted) return;

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NextView(
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
                icon: Image.asset(
                  "assets/shutter.png",
                  scale: 2.5,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

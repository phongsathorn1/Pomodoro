import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class AddProfilePicScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProfilePicScreenState();
  }
}

class AddProfilePicScreenState extends State<AddProfilePicScreen> {
  CameraController cameraController;

  @override
  void initState() {
    super.initState();
    this.initCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized || cameraController == null) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController));
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
}
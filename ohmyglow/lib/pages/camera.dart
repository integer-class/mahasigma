import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ohmyglow/pages/imageDisplay.dart';
import 'package:tflite/tflite.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  bool _isFlashOn = false;
  int _selectedCameraIndex = 0;

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    _selectedCameraIndex = _cameras.indexWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    if (_selectedCameraIndex == -1) {
      _selectedCameraIndex = 0;
    }

    _cameraController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDisplayPage(
            imagePath: imageFile.path,
          ),
        ),
      );
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final image = await _cameraController!.takePicture();
      List<dynamic>? recognitions = await _runObjectDetection(image.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDisplayPage(
            imagePath: image.path,
            recognitions: recognitions,
          ),
        ),
      );
    }
  }

  Future<List<dynamic>?> _runObjectDetection(String imagePath) async {
    return await Tflite.detectObjectOnImage(
      path: imagePath,
      model: "SSDMobileNet",
      threshold: 0.5,
      asynch: true,
    );
  }

  Future<void> _toggleFlash() async {
    if (_cameraController != null) {
      _isFlashOn = !_isFlashOn;
      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  Future<void> _switchCamera() async {
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;

    await _cameraController?.dispose();
    _cameraController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CameraPreview(_cameraController!),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purpleAccent, width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  ),
                  onPressed: _toggleFlash, // Toggle flash
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.photo,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: _pickImageFromGallery, // Open gallery
                ),
                IconButton(
                  icon: Icon(Icons.camera, color: Colors.black, size: 60),
                  onPressed: _capturePhoto, // Capture photo
                ),
                IconButton(
                  icon: Icon(
                    Icons.flip_camera_android,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: _switchCamera, // Flip camera
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

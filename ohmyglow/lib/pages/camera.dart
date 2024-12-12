import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ohmyglow/pages/imageDisplay.dart';

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

    try {
      // Pick the image from the gallery
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Send the image to the API
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://20.190.121.86/api/check_skin'),
        );
        request.files.add(
          await http.MultipartFile.fromPath('files', pickedFile.path),
        );

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          // Membaca respons dari API
          String result = await response.stream.bytesToString();
          int diseaseId = _parseDiseaseId(result); // Panggil fungsi parsing

          if (diseaseId == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No Face Detected")),
            );
          }
          if (diseaseId > 0) {
            // Debugging untuk memastikan parsing benar
            print('Response from API: $result');
            print('Parsed diseaseId: $diseaseId');

            // Navigasi ke halaman berikutnya
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDisplayPage(
                  imagePath: pickedFile.path,
                  apiResponse: result,
                  diseaseId: diseaseId,
                ),
              ),
            );
          }
        } else {
          print('Error: ${response.reasonPhrase}');
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  int _parseDiseaseId(String result) {
    final Map<String, dynamic> jsonData = json.decode(result);

    // Validasi JSON respons dan ambil ID penyakit
    if (jsonData['success'] == true && jsonData['skin'] != null) {
      return jsonData['skin']['id']; // Mengambil 'id' dari field 'skin'
    } else {
      return -1;
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();

        // Kirim gambar ke API
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://20.190.121.86/api/check_skin'),
        );
        request.files.add(
          await http.MultipartFile.fromPath('files', image.path),
        );

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          String result = await response.stream.bytesToString();
          int diseaseId = _parseDiseaseId(result); // Tambahkan logika parsing
          print('Response dari API: $result');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDisplayPage(
                imagePath: image.path,
                apiResponse: result,
                diseaseId: diseaseId,
              ),
            ),
          );
        } else {
          print('Error: ${response.reasonPhrase}');
        }
      } catch (e) {
        print('Terjadi kesalahan: $e');
      }
    }
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
                top: 150,
                left: 10,
                child: Image.asset("images/maximize-2.png"),
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

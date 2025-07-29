import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// Ensure XFile and ImageSource are available from image_picker
// ...existing code...

class CropDetectorScreen extends StatefulWidget {
  @override
  State<CropDetectorScreen> createState() => _CropDetectorScreenState();
}

class _CropDetectorScreenState extends State<CropDetectorScreen> {
  XFile? _image;
  String _result = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _result = 'Analyzing...';
      });
      await _analyzeImage(pickedFile);
    }
  }

  Future<void> _analyzeImage(XFile image) async {
    // TODO: Load and run TFLite model for crop disease detection
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _result = 'Healthy Crop (Sample AI Result)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop Detector')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text('Scan crops for diseases using AI', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            _image != null
                ? Image.file(
                    File(_image!.path),
                    height: 180,
                  )
                : SizedBox(),
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Capture Crop Image'),
              onPressed: _pickImage,
            ),
            SizedBox(height: 16),
            Text(_result.isEmpty ? 'Results will appear here...' : _result, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

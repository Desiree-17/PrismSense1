import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TritanopiaPage extends StatefulWidget {
  @override
  _TritanopiaPageState createState() => _TritanopiaPageState();
}

class _TritanopiaPageState extends State<TritanopiaPage> {
  img.Image? _originalImage;
  File? _filteredImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.grey),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/bg.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: _filteredImage != null
                        ? Image.file(
                            _filteredImage!,
                            fit: BoxFit.cover,
                          )
                        : (_originalImage != null
                            ? Image.memory(
                                Uint8List.fromList(
                                    img.encodePng(_originalImage!)),
                                fit: BoxFit.cover,
                              )
                            : const Center(child: Text('No image selected'))),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Select an Image',
                      style: TextStyle(fontSize: 20), // Increase font size
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _applyTritanopiaFilter,
                    child: const Text(
                      'Convert Image',
                      style: TextStyle(fontSize: 20), // Increase font size
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _originalImage =
            img.decodeImage(File(pickedFile.path).readAsBytesSync());
        _filteredImage = null;
      });
    }
  }

  Future<void> _applyTritanopiaFilter() async {
    if (_originalImage == null) return;

    final List<List<double>> tritanopiaMatrix = [
      [0.67908, 0.32091, 0.0],
      [0.12279, 0.86812, 0.00909],
      [0.207, 0.79289, 0.0],
    ];

    img.Image filteredImage =
        _applyColorBlindnessMatrix(_originalImage!, tritanopiaMatrix);

    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/tritanopia_filtered_image.png';
    File(outputPath).writeAsBytesSync(img.encodePng(filteredImage));

    setState(() {
      _filteredImage = File(outputPath);
    });
  }

  img.Image _applyColorBlindnessMatrix(
      img.Image image, List<List<double>> matrix) {
    img.Image result = img.Image(image.width, image.height);

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);

        int r = img.getRed(pixel);
        int g = img.getGreen(pixel);
        int b = img.getBlue(pixel);

        int newR = (matrix[0][0] * r + matrix[0][1] * g + matrix[0][2] * b)
            .clamp(0, 255)
            .toInt();
        int newG = (matrix[1][0] * r + matrix[1][1] * g + matrix[1][2] * b)
            .clamp(0, 255)
            .toInt();
        int newB = (matrix[2][0] * r + matrix[2][1] * g + matrix[2][2] * b)
            .clamp(0, 255)
            .toInt();

        result.setPixel(x, y, img.getColor(newR, newG, newB));
      }
    }

    return result;
  }
}
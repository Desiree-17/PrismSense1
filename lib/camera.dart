// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);

//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool _isFlashOn = false;
//   bool _isFrontCamera = false;
//   bool _isCameraChanging = false;
//   double _zoomLevel = 1.0;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;

//     _controller = CameraController(
//       selectedCamera,
//       ResolutionPreset.ultraHigh,
//     );

//     await _controller.initialize();

//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();

//     if (_isFlashOn) {
//       await _controller.setFlashMode(FlashMode.torch);
//     } else {
//       await _controller.setFlashMode(FlashMode.off);
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _toggleFlash() async {
//     if (!_controller.value.isInitialized) {
//       return;
//     }
//     setState(() {
//       _isFlashOn = !_isFlashOn;
//     });
//     if (_isFlashOn) {
//       await _controller.setFlashMode(FlashMode.torch);
//     } else {
//       await _controller.setFlashMode(FlashMode.off);
//     }
//   }

//   Future<void> _toggleCamera() async {
//     setState(() {
//       _isCameraChanging = true;
//     });

//     final cameras = await availableCameras();
//     final newCamera = _isFrontCamera ? cameras.first : cameras.last;

//     await _controller.dispose();

//     _controller = CameraController(
//       newCamera,
//       ResolutionPreset.ultraHigh,
//     );

//     _initializeControllerFuture = _controller.initialize();
//     await _initializeControllerFuture;

//     if (_isFlashOn) {
//       await _controller.setFlashMode(FlashMode.torch);
//     } else {
//       await _controller.setFlashMode(FlashMode.off);
//     }

//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();

//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//       _isCameraChanging = false;
//     });
//   }

//   Future<void> _zoomIn() async {
//     if (!_controller.value.isInitialized) {
//       return;
//     }
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel + 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     await _controller.setZoomLevel(_zoomLevel);
//   }

//   Future<void> _zoomOut() async {
//     if (!_controller.value.isInitialized) {
//       return;
//     }
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel - 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     await _controller.setZoomLevel(_zoomLevel);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         backgroundColor: const Color(0xFF534F7D),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 20.0), // Added padding here
//           child: _isCameraChanging
//               ? const Center(child: CircularProgressIndicator())
//               : FutureBuilder<void>(
//                   future: _initializeControllerFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return Stack(
//                         children: [
//                           Positioned.fill(
//                             child: AspectRatio(
//                               aspectRatio: _controller.value.aspectRatio,
//                               child: CameraPreview(_controller),
//                             ),
//                           ),
//                           Positioned(
//                             top: 20,
//                             right: 20,
//                             child: Column(
//                               children: [
//                                 FloatingActionButton(
//                                   onPressed: _toggleFlash,
//                                   backgroundColor: const Color(0xFF534F7D),
//                                   child: _isFlashOn
//                                       ? const Icon(Icons.flash_off)
//                                       : const Icon(Icons.flash_on),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 FloatingActionButton(
//                                   onPressed: _toggleCamera,
//                                   backgroundColor: const Color(0xFF534F7D),
//                                   child: const Icon(Icons.switch_camera),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 FloatingActionButton(
//                                   onPressed: _zoomIn,
//                                   backgroundColor: const Color(0xFF534F7D),
//                                   child: const Icon(Icons.zoom_in),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 FloatingActionButton(
//                                   onPressed: _zoomOut,
//                                   backgroundColor: const Color(0xFF534F7D),
//                                   child: const Icon(Icons.zoom_out),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math'; // Import dart:math for max function
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ColorData {
  final int r, g, b;
  final String label;
  ColorData(this.r, this.g, this.b, this.label);
}

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = false, _isFrontCamera = false, _isCameraChanging = false;
  double _zoomLevel = 1.0, _minAvailableZoom = 1.0, _maxAvailableZoom = 1.0;
  List<ColorData> colorDataset = [];
  String predictedColor = 'Detecting...';
  int kNeighbors = 5;
  DateTime lastProcessedTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
    _loadDataset();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;
    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.ultraHigh,
      imageFormatGroup:
          ImageFormatGroup.yuv420, // Specify the image format group if needed
    );
    await _controller.initialize();
    _minAvailableZoom = await _controller.getMinZoomLevel();
    _maxAvailableZoom = await _controller.getMaxZoomLevel();
    _updateFlashMode();
    _controller.startImageStream(_processCameraImage);
  }

  void _updateFlashMode() async {
    await _controller
        .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  Future<void> _loadDataset() async {
    final data =
        await rootBundle.loadString('images/Color_Variations_Dataset.csv');
    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      final values = line.split(',');
      if (values.length == 4 && values[0] != 'R') {
        int r = int.parse(values[0].trim());
        int g = int.parse(values[1].trim());
        int b = int.parse(values[2].trim());
        String label = values[3].trim();
        colorDataset.add(ColorData(r, g, b, label));
      }
    }
  }

  void _processCameraImage(CameraImage image) {
    print("Format: ${image.format.group}");
    if (DateTime.now().difference(lastProcessedTime).inSeconds < 2) return;
    final int centerX = (image.width / 2).round();
    final int centerY = (image.height / 2).round();
    final int uvIndex = image.planes[1].bytesPerRow * (centerY / 2).round() +
        (centerX / 2).round();

    final y =
        image.planes[0].bytes[centerY * image.planes[0].bytesPerRow + centerX];
    final u = image.planes[1].bytes[uvIndex];
    final v = image.planes[2].bytes[uvIndex];

    // Print YUV values before processing
    print("YUV Values: Y=$y, U=$u, V=$v");

    int r = (y + 1.402 * (v - 128)).round().clamp(0, 255);
    int g =
        (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round().clamp(0, 255);
    int b = (y + 1.772 * (u - 128)).round().clamp(0, 255);

    // Print RGB values after conversion
    print("Converted RGB Values: R=$r, G=$g, B=$b");

    List<int> normalized = normalizeColor(r, g, b);
    setState(() {
      predictedColor =
          classifyColor(normalized[0], normalized[1], normalized[2]);
      lastProcessedTime = DateTime.now();

      // Print predicted color
      print("Predicted Color: $predictedColor");
    });
  }

  List<int> normalizeColor(int r, int g, int b) {
    int maxColor = max(r, max(g, b));
    return [
      ((r / maxColor) * 255).round(),
      ((g / maxColor) * 255).round(),
      ((b / maxColor) * 255).round()
    ];
  }

  String classifyColor(int r, int g, int b) {
    List<Map<String, dynamic>> distances = [];
    for (var color in colorDataset) {
      double distance = ((r - color.r) * (r - color.r) +
              (g - color.g) * (g - color.g) +
              (b - color.b) * (b - color.b))
          .toDouble();
      distances.add({'distance': distance, 'label': color.label});
    }
    distances.sort((a, b) => a['distance'].compareTo(b['distance']));
    Map<String, int> voteCount = {};
    for (int i = 0; i < kNeighbors && i < distances.length; i++) {
      String label = distances[i]['label'];
      voteCount[label] = (voteCount[label] ?? 0) + 1;
    }
    return voteCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Color Detection'), backgroundColor: Color(0xFF534F7D)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: _isCameraChanging
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CameraPreview(_controller),
                            ),
                          ),
                          Center(
                              child: CustomPaint(painter: CrosshairPainter())),
                          Positioned(
                              bottom: 20,
                              child: Text(predictedColor,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Column(
                              children: [
                                FloatingActionButton(
                                    onPressed: _toggleFlash,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.flash_off)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _toggleCamera,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.switch_camera)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _zoomIn,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.zoom_in)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _zoomOut,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.zoom_out)),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
        ),
      ),
    );
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    _updateFlashMode();
  }

  void _toggleCamera() async {
    setState(() {
      _isCameraChanging = true;
    });
    final cameras = await availableCameras();
    final newCamera = _isFrontCamera ? cameras.first : cameras.last;
    await _controller.dispose();
    _controller = CameraController(newCamera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;
    _updateFlashMode();
    _minAvailableZoom = await _controller.getMinZoomLevel();
    _maxAvailableZoom = await _controller.getMaxZoomLevel();
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _isCameraChanging = false;
    });
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel =
          (_zoomLevel + 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
    });
    _controller.setZoomLevel(_zoomLevel);
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel =
          (_zoomLevel - 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
    });
    _controller.setZoomLevel(_zoomLevel);
  }
}

class CrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(Offset(center.dx - 10, center.dy),
        Offset(center.dx + 10, center.dy), paint);
    canvas.drawLine(Offset(center.dx, center.dy - 10),
        Offset(center.dx, center.dy + 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
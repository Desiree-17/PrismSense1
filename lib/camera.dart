// // ignore_for_file: prefer_const_constructors

// import 'dart:async';
// // ignore: unused_import
// import 'dart:ui' as ui;
// import 'dart:math'; // Import dart:math for max function
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class ColorData {
//   final int r, g, b;
//   final String label;
//   ColorData(this.r, this.g, this.b, this.label);
// }

// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);
//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool _isFlashOn = false, _isFrontCamera = false, _isCameraChanging = false;
//   double _zoomLevel = 1.0, _minAvailableZoom = 1.0, _maxAvailableZoom = 1.0;
//   List<ColorData> colorDataset = [];
//   String predictedColor = 'Detecting...';
//   int kNeighbors = 5;
//   DateTime lastProcessedTime = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = _initializeCamera();
//     _loadDataset();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;
//     _controller = CameraController(
//       selectedCamera,
//       ResolutionPreset.ultraHigh,
//       imageFormatGroup:
//           ImageFormatGroup.yuv420, // Specify the image format group if needed
//     );
//     await _controller.initialize();
//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();
//     _updateFlashMode();
//     _controller.startImageStream(_processCameraImage);
//   }

//   void _updateFlashMode() async {
//     await _controller
//         .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
//   }

//   Future<void> _loadDataset() async {
//     final data =
//         await rootBundle.loadString('images/Color_Variations_Dataset.csv');
//     final lines = data.split('\n');
//     for (var line in lines) {
//       if (line.trim().isEmpty) continue;
//       final values = line.split(',');
//       if (values.length == 4 && values[0] != 'R') {
//         int r = int.parse(values[0].trim());
//         int g = int.parse(values[1].trim());
//         int b = int.parse(values[2].trim());
//         String label = values[3].trim();
//         colorDataset.add(ColorData(r, g, b, label));
//       }
//     }
//   }

//   // ignore: duplicate_ignore
//   void _processCameraImage(CameraImage image) {
//     // ignore: avoid_print
//     print("Format: ${image.format.group}");
//     if (DateTime.now().difference(lastProcessedTime).inSeconds < 2) return;
//     final int centerX = (image.width / 2).round();
//     final int centerY = (image.height / 2).round();
//     final int uvIndex = image.planes[1].bytesPerRow * (centerY / 2).round() +
//         (centerX / 2).round();

//     final y =
//         image.planes[0].bytes[centerY * image.planes[0].bytesPerRow + centerX];
//     final u = image.planes[1].bytes[uvIndex];
//     final v = image.planes[2].bytes[uvIndex];

//     // Print YUV values before processing
//     // ignore: avoid_print
//     print("YUV Values: Y=$y, U=$u, V=$v");

//     int r = (y + 1.402 * (v - 128)).round().clamp(0, 255);
//     int g =
//         (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round().clamp(0, 255);
//     int b = (y + 1.772 * (u - 128)).round().clamp(0, 255);

//     // Print RGB values after conversion
//     print("Converted RGB Values: R=$r, G=$g, B=$b");

//     List<int> normalized = normalizeColor(r, g, b);
//     setState(() {
//       predictedColor =
//           classifyColor(normalized[0], normalized[1], normalized[2]);
//       lastProcessedTime = DateTime.now();

//       // Print predicted color
//       print("Predicted Color: $predictedColor");
//     });
//   }

//   List<int> normalizeColor(int r, int g, int b) {
//     int maxColor = max(r, max(g, b));
//     return [
//       ((r / maxColor) * 255).round(),
//       ((g / maxColor) * 255).round(),
//       ((b / maxColor) * 255).round()
//     ];
//   }

//   String classifyColor(int r, int g, int b) {
//     List<Map<String, dynamic>> distances = [];
//     for (var color in colorDataset) {
//       double distance = ((r - color.r) * (r - color.r) +
//               (g - color.g) * (g - color.g) +
//               (b - color.b) * (b - color.b))
//           .toDouble();
//       distances.add({'distance': distance, 'label': color.label});
//     }
//     distances.sort((a, b) => a['distance'].compareTo(b['distance']));
//     Map<String, int> voteCount = {};
//     for (int i = 0; i < kNeighbors && i < distances.length; i++) {
//       String label = distances[i]['label'];
//       voteCount[label] = (voteCount[label] ?? 0) + 1;
//     }
//     return voteCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xFF534F7D),
//         title: Image.asset(
//           'images/appbarlogo4.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 0.0),
//           child: _isCameraChanging
//               ? Center(child: CircularProgressIndicator())
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
//                           Center(
//                               child: CustomPaint(painter: CrosshairPainter())),
//                           Positioned(
//                             top: 20,
//                             right: 20,
//                             child: Column(
//                               children: [
//                                 FloatingActionButton(
//                                     onPressed: _toggleFlash,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.flash_off,
//                                         color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _toggleCamera,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.switch_camera,
//                                         color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _zoomIn,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.zoom_in,
//                                         color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _zoomOut,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.zoom_out,
//                                         color: Colors.white)),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               padding: EdgeInsets.all(20),
//                               color: Color(
//                                   0xFF534F7D), // Background color for the padding
//                               child: Text(
//                                 predictedColor,
//                                 style: TextStyle(
//                                   color: Colors.white, // Text color
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//         ),
//       ),
//     );
//   }

//   void _toggleFlash() {
//     setState(() {
//       _isFlashOn = !_isFlashOn;
//     });
//     _updateFlashMode();
//   }

//   void _toggleCamera() async {
//     setState(() {
//       _isCameraChanging = true;
//     });
//     final cameras = await availableCameras();
//     final newCamera = _isFrontCamera ? cameras.first : cameras.last;
//     await _controller.dispose();
//     _controller = CameraController(newCamera, ResolutionPreset.ultraHigh);
//     _initializeControllerFuture = _controller.initialize();
//     await _initializeControllerFuture;
//     _updateFlashMode();
//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();
//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//       _isCameraChanging = false;
//     });
//   }

//   void _zoomIn() {
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel + 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     _controller.setZoomLevel(_zoomLevel);
//   }

//   void _zoomOut() {
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel - 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     _controller.setZoomLevel(_zoomLevel);
//   }
// }

// class CrosshairPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final center = Offset(size.width / 2, size.height / 2);
//     canvas.drawLine(Offset(center.dx - 10, center.dy),
//         Offset(center.dx + 10, center.dy), paint);
//     canvas.drawLine(Offset(center.dx, center.dy - 10),
//         Offset(center.dx, center.dy + 10), paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// ignore_for_file: prefer_const_constructors

import 'dart:async';
// ignore: unused_import
import 'dart:ui' as ui;
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
  // ignore: library_private_types_in_public_api
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

  // ignore: duplicate_ignore
  void _processCameraImage(CameraImage image) {
    // ignore: avoid_print
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
    // ignore: avoid_print
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
        centerTitle: true,
        backgroundColor: Color(0xFF534F7D),
        title: Image.asset(
          'images/appbarlogo4.png',
          fit: BoxFit.contain,
          height: 27,
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Change back button color to white
      ),
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
                            top: 20,
                            right: 20,
                            child: Column(
                              children: [
                                FloatingActionButton(
                                    onPressed: _toggleFlash,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.flash_off,
                                        color: Colors.white)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _toggleCamera,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.switch_camera,
                                        color: Colors.white)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _zoomIn,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.zoom_in,
                                        color: Colors.white)),
                                SizedBox(height: 16),
                                FloatingActionButton(
                                    onPressed: _zoomOut,
                                    backgroundColor: Color(0xFF534F7D),
                                    child: Icon(Icons.zoom_out,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              color: Color(
                                  0xFF534F7D), // Background color for the padding
                              child: Text(
                                predictedColor,
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
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

// import 'dart:async';
// // ignore: unused_import
// import 'dart:ui' as ui;
// import 'dart:math'; // Import dart:math for max function
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class ColorData {
//   final int r, g, b;
//   final String label;
//   ColorData(this.r, this.g, this.b, this.label);
// }

// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);
//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool _isFlashOn = false, _isFrontCamera = false, _isCameraChanging = false;
//   double _zoomLevel = 1.0, _minAvailableZoom = 1.0, _maxAvailableZoom = 1.0;
//   List<ColorData> colorDataset = [];
//   String predictedColor = 'Detecting...';
//   int kNeighbors = 5;
//   DateTime lastProcessedTime = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = _initializeCamera();
//     _loadDataset();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final selectedCamera = _isFrontCamera ? cameras.last : cameras.first;
//     _controller = CameraController(
//       selectedCamera,
//       ResolutionPreset.ultraHigh,
//       imageFormatGroup:
//           ImageFormatGroup.yuv420, // Specify the image format group if needed
//     );
//     await _controller.initialize();
//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();
//     _updateFlashMode();
//     _controller.startImageStream(_processCameraImage);
//   }

//   void _updateFlashMode() async {
//     await _controller
//         .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
//   }

//   Future<void> _loadDataset() async {
//     final data =
//         await rootBundle.loadString('images/Color_Variations_Dataset.csv');
//     final lines = data.split('\n');
//     for (var line in lines) {
//       if (line.trim().isEmpty) continue;
//       final values = line.split(',');
//       if (values.length == 4 && values[0] != 'R') {
//         int r = int.parse(values[0].trim());
//         int g = int.parse(values[1].trim());
//         int b = int.parse(values[2].trim());
//         String label = values[3].trim();
//         colorDataset.add(ColorData(r, g, b, label));
//       }
//     }
//   }

//   void _processCameraImage(CameraImage image) {
//     if (DateTime.now().difference(lastProcessedTime).inSeconds < 2) return;

//     final int centerX = (image.width / 2).round();
//     final int centerY = (image.height / 2).round();

//     print("Center: ($centerX, $centerY)");

//     // Ensure the center indices are within bounds
//     if (centerX >= image.width || centerY >= image.height) {
//       print("Center indices out of bounds");
//       return;
//     }

//     final int uvCenterX = (centerX / 2).round();
//     final int uvCenterY = (centerY / 2).round();

//     final int uvIndex = image.planes[1].bytesPerRow * uvCenterY + uvCenterX;
//     final int yIndex = centerY * image.planes[0].bytesPerRow + centerX;

//     print("Y index: $yIndex, UV index: $uvIndex");

//     // Ensure the indices are within bounds
//     if (yIndex >= image.planes[0].bytes.length || 
//         uvIndex >= image.planes[1].bytes.length || 
//         uvIndex >= image.planes[2].bytes.length) {
//       print("Indices out of bounds: Y index: $yIndex, UV index: $uvIndex");
//       return;
//     }

//     final y = image.planes[0].bytes[yIndex];
//     final u = image.planes[1].bytes[uvIndex];
//     final v = image.planes[2].bytes[uvIndex];

//     print("YUV Values: Y=$y, U=$u, V=$v");

//     int r = (y + 1.402 * (v - 128)).round().clamp(0, 255);
//     int g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round().clamp(0, 255);
//     int b = (y + 1.772 * (u - 128)).round().clamp(0, 255);

//     print("Converted RGB Values: R=$r, G=$g, B=$b");

//     List<int> normalized = normalizeColor(r, g, b);
//     setState(() {
//       predictedColor = classifyColor(normalized[0], normalized[1], normalized[2]);
//       lastProcessedTime = DateTime.now();
//       print("Predicted Color: $predictedColor");
//     });
//   }

//   List<int> normalizeColor(int r, int g, int b) {
//     int maxColor = max(r, max(g, b));
//     return [
//       ((r / maxColor) * 255).round(),
//       ((g / maxColor) * 255).round(),
//       ((b / maxColor) * 255).round()
//     ];
//   }

//   String classifyColor(int r, int g, int b) {
//     List<Map<String, dynamic>> distances = [];
//     for (var color in colorDataset) {
//       double distance = ((r - color.r) * (r - color.r) +
//               (g - color.g) * (g - color.g) +
//               (b - color.b) * (b - color.b))
//           .toDouble();
//       distances.add({'distance': distance, 'label': color.label});
//     }
//     distances.sort((a, b) => a['distance'].compareTo(b['distance']));
//     Map<String, int> voteCount = {};
//     for (int i = 0; i < kNeighbors && i < distances.length; i++) {
//       String label = distances[i]['label'];
//       voteCount[label] = (voteCount[label] ?? 0) + 1;
//     }
//     return voteCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xFF534F7D),
//         title: Image.asset(
//           'images/appbarlogo4.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         iconTheme: IconThemeData(
//             color: Colors.white), // Change back button color to white
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 0.0),
//           child: _isCameraChanging
//               ? Center(child: CircularProgressIndicator())
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
//                           Center(
//                               child: CustomPaint(painter: CrosshairPainter())),
//                           Positioned(
//                             top: 20,
//                             right: 20,
//                             child: Column(
//                               children: [
//                                 FloatingActionButton(
//                                     onPressed: _toggleFlash,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(
//                                       _isFlashOn ? Icons.flash_on : Icons.flash_off,
//                                       color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _toggleCamera,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.switch_camera,
//                                         color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _zoomIn,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.zoom_in,
//                                         color: Colors.white)),
//                                 SizedBox(height: 16),
//                                 FloatingActionButton(
//                                     onPressed: _zoomOut,
//                                     backgroundColor: Color(0xFF534F7D),
//                                     child: Icon(Icons.zoom_out,
//                                         color: Colors.white)),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               padding: EdgeInsets.all(20),
//                               color: Color(
//                                   0xFF534F7D), // Background color for the padding
//                               child: Text(
//                                 predictedColor,
//                                 style: TextStyle(
//                                   color: Colors.white, // Text color
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//         ),
//       ),
//     );
//   }

//   void _toggleFlash() {
//     setState(() {
//       _isFlashOn = !_isFlashOn;
//     });
//     _updateFlashMode();
//   }

//   void _toggleCamera() async {
//     setState(() {
//       _isCameraChanging = true;
//     });
//     final cameras = await availableCameras();
//     final newCamera = _isFrontCamera ? cameras.first : cameras.last;
//     await _controller.dispose();
//     _controller = CameraController(newCamera, ResolutionPreset.ultraHigh);
//     _initializeControllerFuture = _controller.initialize();
//     await _initializeControllerFuture;
//     _updateFlashMode();
//     _minAvailableZoom = await _controller.getMinZoomLevel();
//     _maxAvailableZoom = await _controller.getMaxZoomLevel();
//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//       _isCameraChanging = false;
//     });
//   }

//   void _zoomIn() {
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel + 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     _controller.setZoomLevel(_zoomLevel);
//   }

//   void _zoomOut() {
//     setState(() {
//       _zoomLevel =
//           (_zoomLevel - 0.1).clamp(_minAvailableZoom, _maxAvailableZoom);
//     });
//     _controller.setZoomLevel(_zoomLevel);
//   }
// }

// class CrosshairPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final center = Offset(size.width / 2, size.height / 2);
//     canvas.drawLine(Offset(center.dx - 10, center.dy),
//         Offset(center.dx + 10, center.dy), paint);
//     canvas.drawLine(Offset(center.dx, center.dy - 10),
//         Offset(center.dx, center.dy + 10), paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

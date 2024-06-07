// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Achromatopsia Simulation'),
//         backgroundColor: const Color(0xFF534F7D),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: const Text('Pick Image'),
//               ),
//               const SizedBox(height: 20),
//               _filteredImage != null
//                   ? Image.file(
//                       _filteredImage!,
//                       fit: BoxFit.cover,
//                     )
//                   : (_originalImage != null
//                       ? Image.memory(
//                           Uint8List.fromList(img.encodePng(_originalImage!)),
//                           fit: BoxFit.cover,
//                         )
//                       : const Center(child: Text('No image selected'))),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _applyAchromatopsiaFilter,
//                 child: const Text('Convert Image'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _originalImage =
//             img.decodeImage(File(pickedFile.path).readAsBytesSync());
//         _filteredImage = null;
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     img.Image filteredImage = _simulateAchromatopsia(_originalImage!);

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     File(outputPath).writeAsBytesSync(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//     });
//   }

//   img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(color: Colors.grey),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Center(
//                     child: _filteredImage != null
//                         ? Image.file(
//                             _filteredImage!,
//                             fit: BoxFit.cover,
//                           )
//                         : (_originalImage != null
//                             ? Image.memory(
//                                 Uint8List.fromList(
//                                     img.encodePng(_originalImage!)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const Center(child: Text('No image selected'))),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _originalImage =
//             img.decodeImage(File(pickedFile.path).readAsBytesSync());
//         _filteredImage = null;
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     img.Image filteredImage = _simulateAchromatopsia(_originalImage!);

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     File(outputPath).writeAsBytesSync(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//     });
//   }

//   img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(color: Colors.grey),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Center(
//                     child: _filteredImage != null
//                         ? Image.file(
//                             _filteredImage!,
//                             fit: BoxFit.cover,
//                           )
//                         : (_originalImage != null
//                             ? Image.memory(
//                                 Uint8List.fromList(
//                                     img.encodePng(_originalImage!)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const Center(child: Text('No image selected'))),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       setState(() {
//         _originalImage =
//             img.decodeImage(File(pickedFile.path).readAsBytesSync());
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     img.Image filteredImage = _simulateAchromatopsia(_originalImage!);

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     File(outputPath).writeAsBytesSync(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(color: Colors.grey),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Center(
//                     child: _filteredImage != null
//                         ? Image.file(
//                             _filteredImage!,
//                             fit: BoxFit.cover,
//                           )
//                         : (_originalImage != null
//                             ? Image.memory(
//                                 Uint8List.fromList(
//                                     img.encodePng(_originalImage!)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const Center(child: Text('No image selected'))),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20), // Increase font size
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset(
//           'images/achro.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         backgroundColor: const Color(0xFF534F7D),
//         iconTheme: IconThemeData(color: Colors.white),
//         // Change back button color to white
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Center(
//                     child: _filteredImage != null
//                         ? Image.file(
//                             _filteredImage!,
//                             fit: BoxFit.cover,
//                           )
//                         : (_originalImage != null
//                             ? Image.memory(
//                                 Uint8List.fromList(
//                                     img.encodePng(_originalImage!)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const Center(child: Text('No image selected'))),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _captureImage,
//                     child: const Text(
//                       'Capture from Camera',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset(
//           'images/achro.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         backgroundColor: const Color(0xFF534F7D),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Center(
//                     child: _filteredImage != null
//                         ? Container(
//                             width: MediaQuery.of(context).size.width - 32,
//                             height: MediaQuery.of(context).size.height / 2,
//                             child: Image.file(
//                               _filteredImage!,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : (_originalImage != null
//                             ? Container(
//                                 width: MediaQuery.of(context).size.width - 32,
//                                 height: MediaQuery.of(context).size.height / 2,
//                                 child: Image.memory(
//                                   Uint8List.fromList(
//                                       img.encodePng(_originalImage!)),
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : const Center(child: Text('No image selected'))),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _captureImage,
//                     child: const Text(
//                       'Capture from Camera',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   double _scale = 1.0;
//   double _baseScale = 1.0;
//   double _prevScale = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset(
//           'images/achro.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         backgroundColor: const Color(0xFF534F7D),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             // Background image
//             Positioned.fill(
//               child: Image.asset(
//                 'images/bg.png', // Replace with your background image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Center(
//                       child: GestureDetector(
//                         onScaleStart: (details) {
//                           _baseScale = _scale;
//                           _prevScale = _scale;
//                         },
//                         onScaleUpdate: (details) {
//                           setState(() {
//                             _scale = _baseScale * details.scale;
//                           });
//                         },
//                         child: _filteredImage != null
//                             ? Transform.scale(
//                                 scale: _scale,
//                                 child: Image.file(
//                                   _filteredImage!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : (_originalImage != null
//                                 ? Transform.scale(
//                                     scale: _scale,
//                                     child: Image.memory(
//                                       Uint8List.fromList(
//                                           img.encodePng(_originalImage!)),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                 : const Center(
//                                     child: Text('No image selected'))),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _captureImage,
//                       child: const Text(
//                         'Capture from Camera',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _pickImage,
//                       child: const Text(
//                         'Select an Image',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _applyAchromatopsiaFilter,
//                       child: const Text(
//                         'Convert Image',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//         _scale = 1.0; // Reset scale on image change
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//         _scale = 1.0; // Reset scale on image change
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class AchromatopsiaPage extends StatefulWidget {
  @override
  _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
}

class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
  img.Image? _originalImage;
  File? _filteredImage;
  String? _filteredImagePath;

  double _scale = 1.0;
  double _baseScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/achro.png',
          fit: BoxFit.contain,
          height: 27,
        ),
        backgroundColor: const Color(0xFF534F7D),
        iconTheme: IconThemeData(color: Colors.white),
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
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onScaleStart: (details) {
                          _baseScale = _scale;
                        },
                        onScaleUpdate: (details) {
                          setState(() {
                            _scale =
                                (_baseScale * details.scale).clamp(1.0, 4.0);
                          });
                        },
                        child: _filteredImage != null
                            ? Transform.scale(
                                scale: _scale,
                                child: Image.file(
                                  _filteredImage!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : (_originalImage != null
                                ? Transform.scale(
                                    scale: _scale,
                                    child: Image.memory(
                                      Uint8List.fromList(
                                          img.encodePng(_originalImage!)),
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : const Center(
                                    child: Text('No image selected'))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _captureImage,
                    child: const Text(
                      'Capture from Camera',
                      style: TextStyle(fontSize: 20),
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
                    onPressed: _pickImage,
                    child: const Text(
                      'Select an Image',
                      style: TextStyle(fontSize: 20),
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
                    onPressed: _applyAchromatopsiaFilter,
                    child: const Text(
                      'Convert Image',
                      style: TextStyle(fontSize: 20),
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
      // Delete the previous filtered image if it exists
      if (_filteredImagePath != null) {
        File(_filteredImagePath!).deleteSync();
        _filteredImagePath = null;
      }

      final imageBytes = await File(pickedFile.path).readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      setState(() {
        _originalImage = originalImage;
        _filteredImage =
            null; // Reset filtered image when a new image is picked
        _scale = 1.0; // Reset scale on image change
      });
    }
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Delete the previous filtered image if it exists
      if (_filteredImagePath != null) {
        File(_filteredImagePath!).deleteSync();
        _filteredImagePath = null;
      }

      final imageBytes = await File(pickedFile.path).readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      setState(() {
        _originalImage = originalImage;
        _filteredImage =
            null; // Reset filtered image when a new image is picked
        _scale = 1.0; // Reset scale on image change
      });
    }
  }

  Future<void> _applyAchromatopsiaFilter() async {
    if (_originalImage == null) return;

    setState(() {
      _filteredImage = null; // Clear the old filtered image
    });

    // Run the color blindness matrix in a separate isolate
    img.Image filteredImage = await compute(
      _simulateAchromatopsia,
      _originalImage!,
    );

    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
    await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

    setState(() {
      _filteredImage = File(outputPath);
      _filteredImagePath = outputPath;
    });
  }

  static img.Image _simulateAchromatopsia(img.Image image) {
    img.Image result = img.Image(image.width, image.height);

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);

        int r = img.getRed(pixel);
        int g = img.getGreen(pixel);
        int b = img.getBlue(pixel);

        int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

        result.setPixel(x, y, img.getColor(gray, gray, gray));
      }
    }

    return result;
  }
}

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset(
//           'images/achro.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         backgroundColor: const Color(0xFF534F7D),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child: Center(
//                       child: _filteredImage != null
//                           ? FittedBox(
//                               fit: BoxFit.contain,
//                               child: Image.file(
//                                 _filteredImage!,
//                               ),
//                             )
//                           : (_originalImage != null
//                               ? FittedBox(
//                                   fit: BoxFit.contain,
//                                   child: Image.memory(
//                                     Uint8List.fromList(
//                                         img.encodePng(_originalImage!)),
//                                   ),
//                                 )
//                               : const Center(child: Text('No image selected'))),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _captureImage,
//                     child: const Text(
//                       'Capture from Camera',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';

// class AchromatopsiaPage extends StatefulWidget {
//   @override
//   _AchromatopsiaPageState createState() => _AchromatopsiaPageState();
// }

// class _AchromatopsiaPageState extends State<AchromatopsiaPage> {
//   img.Image? _originalImage;
//   File? _filteredImage;
//   String? _filteredImagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset(
//           'images/achro.png',
//           fit: BoxFit.contain,
//           height: 27,
//         ),
//         backgroundColor: const Color(0xFF534F7D),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'images/bg.png', // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child: Center(
//                       child: _filteredImage != null
//                           ? FittedBox(
//                               fit: BoxFit.contain,
//                               child: Image.file(
//                                 _filteredImage!,
//                               ),
//                             )
//                           : (_originalImage != null
//                               ? FittedBox(
//                                   fit: BoxFit.contain,
//                                   child: Image.memory(
//                                     Uint8List.fromList(
//                                         img.encodePng(_originalImage!)),
//                                   ),
//                                 )
//                               : const Center(child: Text('No image selected'))),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () => _rotateImage(-90),
//                         child:
//                             const Icon(Icons.rotate_left, color: Colors.white),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.all(10),
//                           backgroundColor: Color(0xFF534F7D),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       ElevatedButton(
//                         onPressed: () => _rotateImage(90),
//                         child:
//                             const Icon(Icons.rotate_right, color: Colors.white),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.all(10),
//                           backgroundColor: Color(0xFF534F7D),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _captureImage,
//                     child: const Text(
//                       'Capture from Camera',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text(
//                       'Select an Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _applyAchromatopsiaFilter,
//                     child: const Text(
//                       'Convert Image',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Delete the previous filtered image if it exists
//       if (_filteredImagePath != null) {
//         File(_filteredImagePath!).deleteSync();
//         _filteredImagePath = null;
//       }

//       final imageBytes = await File(pickedFile.path).readAsBytes();
//       final originalImage = img.decodeImage(imageBytes);

//       setState(() {
//         _originalImage = originalImage;
//         _filteredImage =
//             null; // Reset filtered image when a new image is picked
//       });
//     }
//   }

//   Future<void> _applyAchromatopsiaFilter() async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Run the color blindness matrix in a separate isolate
//     img.Image filteredImage = await compute(
//       _simulateAchromatopsia,
//       _originalImage!,
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/achromatopsia_filtered_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(filteredImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   Future<void> _rotateImage(double angle) async {
//     if (_originalImage == null) return;

//     setState(() {
//       _filteredImage = null; // Clear the old filtered image
//     });

//     // Rotate the image in a separate isolate
//     img.Image rotatedImage = await compute(
//       _rotate,
//       {'image': _originalImage!, 'angle': angle},
//     );

//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = '${tempDir.path}/rotated_image.png';
//     await File(outputPath).writeAsBytes(img.encodePng(rotatedImage));

//     setState(() {
//       _filteredImage = File(outputPath);
//       _filteredImagePath = outputPath;
//     });
//   }

//   static img.Image _rotate(Map<String, dynamic> params) {
//     img.Image image = params['image'];
//     double angle = params['angle'];

//     return img.copyRotate(image, angle);
//   }

//   static img.Image _simulateAchromatopsia(img.Image image) {
//     img.Image result = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         int pixel = image.getPixel(x, y);

//         int r = img.getRed(pixel);
//         int g = img.getGreen(pixel);
//         int b = img.getBlue(pixel);

//         int gray = (0.299 * r + 0.587 * g + 0.114 * b).clamp(0, 255).toInt();

//         result.setPixel(x, y, img.getColor(gray, gray, gray));
//       }
//     }

//     return result;
//   }
// }

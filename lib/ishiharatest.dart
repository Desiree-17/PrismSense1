// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class IshiharaTestPage extends StatefulWidget {
//   const IshiharaTestPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _IshiharaTestPageState createState() => _IshiharaTestPageState();
// }

// class _IshiharaTestPageState extends State<IshiharaTestPage> {
//   final Map<int, String> _answers = {};
//   final List<GlobalKey<FormState>> _formKeys =
//       List.generate(25, (index) => GlobalKey<FormState>());
//   int _currentPage = 0;
//   bool _showDisclaimer = true;

//   final Map<int, List<String>> _results = {
//     1: ['12', '12', '12'],
//     2: ['8', '3', '0'],
//     3: ['6', '5', '0'],
//     4: ['29', '70', '0'],
//     5: ['57', '35', '0'],
//     6: ['5', '2', '0'],
//     7: ['3', '5', '0'],
//     8: ['15', '17', '0'],
//     9: ['74', '21', '0'],
//     10: ['2', '0', '0'],
//     11: ['6', '0', '0'],
//     12: ['97', '0', '0'],
//     13: ['45', '0', '0'],
//     14: ['5', '0', '0'],
//     15: ['7', '0', '0'],
//     16: ['16', '0', '0'],
//     17: ['73', '0', '0'],
//     18: ['0', '5', '0'],
//     19: ['0', '2', '0'],
//     20: ['0', '45', '0'],
//     21: ['0', '73', '0'],
//   };

//   void _nextPage() {
//     if (_currentPage < 24) {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         setState(() {
//           _currentPage++;
//         });
//       }
//     } else {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         if (_answers.length == 25) {
//           _showEndDisclaimer();
//         } else {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Incomplete Test'),
//               content: Text('Please answer all the plates before submitting.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       setState(() {
//         _currentPage--;
//       });
//     }
//   }

//   void _proceedToTest() {
//     setState(() {
//       _showDisclaimer = false;
//     });
//   }

//   void _showEndDisclaimer() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Disclaimer'),
//         content: Text(
//             'Note: The results of this test may not be entirely accurate and should not be considered a substitute for professional medical advice. It is always recommended to consult with a qualified healthcare professional for a comprehensive evaluation of your vision.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _showResults();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showResults() {
//     String result = _determineResult();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Test Result'),
//         content: Text(result),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop(); // Go back to the home page
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   String _determineResult() {
//     int normalCount = 0;
//     int redGreenCount = 0;
//     int totalCount = 0;

//     _answers.forEach((plate, answer) {
//       if (_results.containsKey(plate)) {
//         if (answer == _results[plate]![0]) normalCount++;
//         if (answer == _results[plate]![1]) redGreenCount++;
//         if (answer == _results[plate]![2]) totalCount++;
//       }
//     });

//     const threshold = 5;

//     if (normalCount < threshold &&
//         redGreenCount < threshold &&
//         totalCount < threshold) {
//       return 'Result could not be determined';
//     }

//     if (totalCount >= threshold &&
//         totalCount > normalCount &&
//         totalCount > redGreenCount) {
//       return 'Total Colorblindness';
//     }

//     if (redGreenCount >= threshold &&
//         redGreenCount > normalCount &&
//         redGreenCount > totalCount) {
//       if (redGreenCount > (normalCount + totalCount)) {
//         return _determineProtanDeutan();
//       } else {
//         return 'Red-Green Deficiency';
//       }
//     }

//     if (normalCount >= threshold &&
//         normalCount > redGreenCount &&
//         normalCount > totalCount) {
//       return 'Normal Eyesight';
//     }

//     return 'Result could not be determined';
//   }

//   String _determineProtanDeutan() {
//     int protanCount = 0;
//     int deutanCount = 0;

//     final Map<int, List<String>> protanDeutanResults = {
//       22: ['6', '2'],
//       23: ['2', '4'],
//       24: ['5', '3'],
//       25: ['6', '9'],
//     };

//     _answers.forEach((plate, answer) {
//       if (protanDeutanResults.containsKey(plate)) {
//         if (answer == protanDeutanResults[plate]![0]) protanCount++;
//         if (answer == protanDeutanResults[plate]![1]) deutanCount++;
//       }
//     });

//     if (protanCount > deutanCount) {
//       return 'You have Protan Deficiency';
//     } else if (deutanCount > protanCount) {
//       return 'You have Deutan Deficiency';
//     } else {
//       return 'Indeterminate (Protan/Deutan)';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('images/ishiharabar.png', height: 30),
//               SizedBox(width: 10),
//             ],
//           ),
//         ),
//         backgroundColor: Color(0xFF534F7D),
//       ),
//       body: _showDisclaimer
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/ishiharagraphic.png',
//                       height: 150,
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'images/ishiharatext.png',
//                       height: 50,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Welcome to the Ishihara Color Blindness Test! This test is a common method to screen for red-green color blindness. The test consists of a series of plates containing colored dots. If you can clearly see a number hidden within the circle of dots, please enter that number. If you are unable to see a number, simply press "0" and proceed to the next plate.',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Note: Please be aware that the accuracy of this digital test may vary due to factors such as the brightness and color settings of your screen, as well as ambient lighting conditions. For a comprehensive evaluation of your color vision, it is advisable to consult with a qualified healthcare professional and undergo a real Ishihara test.',
//                       style:
//                           TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 40),
//                     ElevatedButton(
//                       onPressed: _proceedToTest,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF534F7D),
//                           fixedSize: Size(200, 50)),
//                       child: Text(
//                         'Proceed to Test',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKeys[_currentPage],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'PLATE ${_currentPage + 1}',
//                         style: TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 10,
//                               offset: Offset(0, 5),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset(
//                           'images/plate${_currentPage + 1}.png',
//                           height: 300,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Enter the number you see',
//                         ),
//                         keyboardType: TextInputType.number,
//                         onSaved: (value) {
//                           _answers[_currentPage + 1] = value ?? '';
//                         },
//                         textAlign: TextAlign.center,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a number';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             onPressed: _previousPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                             ),
//                             child: Text(
//                               'Previous',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: _nextPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                             ),
//                             child: Text(
//                               _currentPage < 24 ? 'Next' : 'Submit',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

// // ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class IshiharaTestPage extends StatefulWidget {
//   const IshiharaTestPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _IshiharaTestPageState createState() => _IshiharaTestPageState();
// }

// class _IshiharaTestPageState extends State<IshiharaTestPage> {
//   final Map<int, String> _answers = {};
//   final List<GlobalKey<FormState>> _formKeys =
//       List.generate(25, (index) => GlobalKey<FormState>());
//   int _currentPage = 0;
//   bool _showDisclaimer = true;

//   final Map<int, List<String>> _results = {
//     1: ['12', '12', '12'],
//     2: ['8', '3', '0'],
//     3: ['6', '5', '0'],
//     4: ['29', '70', '0'],
//     5: ['57', '35', '0'],
//     6: ['5', '2', '0'],
//     7: ['3', '5', '0'],
//     8: ['15', '17', '0'],
//     9: ['74', '21', '0'],
//     10: ['2', '0', '0'],
//     11: ['6', '0', '0'],
//     12: ['97', '0', '0'],
//     13: ['45', '0', '0'],
//     14: ['5', '0', '0'],
//     15: ['7', '0', '0'],
//     16: ['16', '0', '0'],
//     17: ['73', '0', '0'],
//     18: ['0', '5', '0'],
//     19: ['0', '2', '0'],
//     20: ['0', '45', '0'],
//     21: ['0', '73', '0'],
//   };

//   void _nextPage() {
//     if (_currentPage < 24) {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         setState(() {
//           _currentPage++;
//         });
//       }
//     } else {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         if (_answers.length == 25) {
//           _showEndDisclaimer();
//         } else {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Incomplete Test'),
//               content: Text('Please answer all the plates before submitting.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       setState(() {
//         _currentPage--;
//       });
//     }
//   }

//   void _proceedToTest() {
//     setState(() {
//       _showDisclaimer = false;
//     });
//   }

//   void _showEndDisclaimer() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Center(
//           child: Text('DISCLAIMER'),
//         ),
//         content: SingleChildScrollView(
//           child: SizedBox(
//             width: double.minPositive, // Adjust the width as needed
//             child: Center(
//               child: Text(
//                 'NOTE: The results of this test may not be entirely accurate and should not be considered a substitute for professional medical advice. It is always recommended to consult with a qualified healthcare professional for a comprehensive evaluation of your vision.',
//                 textAlign: TextAlign.justify, // Justify the text
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _showResults();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showResults() {
//     String result = _determineResult();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('TEST RESULT'),
//         content: Text(result),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop(); // Go back to the home page
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   String _determineResult() {
//     int normalCount = 0;
//     int redGreenCount = 0;
//     int totalCount = 0;

//     _answers.forEach((plate, answer) {
//       if (_results.containsKey(plate)) {
//         if (answer == _results[plate]![0]) normalCount++;
//         if (answer == _results[plate]![1]) redGreenCount++;
//         if (answer == _results[plate]![2]) totalCount++;
//       }
//     });

//     const threshold = 5;

//     if (normalCount < threshold &&
//         redGreenCount < threshold &&
//         totalCount < threshold) {
//       return 'Result could not be determined';
//     }

//     if (totalCount >= threshold &&
//         totalCount > normalCount &&
//         totalCount > redGreenCount) {
//       return 'Total Colorblindness';
//     }

//     if (redGreenCount >= threshold &&
//         redGreenCount > normalCount &&
//         redGreenCount > totalCount) {
//       if (redGreenCount > (normalCount + totalCount)) {
//         return _determineProtanDeutan();
//       } else {
//         return 'Red-Green Deficiency';
//       }
//     }

//     if (normalCount >= threshold &&
//         normalCount > redGreenCount &&
//         normalCount > totalCount) {
//       return 'Normal Eyesight';
//     }

//     return 'Result could not be determined';
//   }

//   String _determineProtanDeutan() {
//     int protanCount = 0;
//     int deutanCount = 0;

//     final Map<int, List<String>> protanDeutanResults = {
//       22: ['6', '2'],
//       23: ['2', '4'],
//       24: ['5', '3'],
//       25: ['6', '9'],
//     };

//     _answers.forEach((plate, answer) {
//       if (protanDeutanResults.containsKey(plate)) {
//         if (answer == protanDeutanResults[plate]![0]) protanCount++;
//         if (answer == protanDeutanResults[plate]![1]) deutanCount++;
//       }
//     });

//     if (protanCount > deutanCount) {
//       return 'You have Protan Deficiency';
//     } else if (deutanCount > protanCount) {
//       return 'You have Deutan Deficiency';
//     } else {
//       return 'You have Red-Green Blindness but Indeterminate (Protan/Deutan)';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('images/ishiharabar.png', height: 30),
//               SizedBox(width: 10),
//             ],
//           ),
//         ),
//         backgroundColor: Color(0xFF534F7D),
//       ),
//       body: _showDisclaimer
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/ishiharagraphic.png',
//                       height: 150,
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'images/ishiharatext.png',
//                       height: 50,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Welcome to the Ishihara Color Blindness Test! This test is a common method to screen for red-green color blindness. The test consists of a series of plates containing colored dots. If you can clearly see a number hidden within the circle of dots, please enter that number. If you are unable to see a number, simply press "0" and proceed to the next plate.',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Note: Please be aware that the accuracy of this digital test may vary due to factors such as the brightness and color settings of your screen, as well as ambient lighting conditions. For a comprehensive evaluation of your color vision, it is advisable to consult with a qualified healthcare professional and undergo a real Ishihara test.',
//                       style:
//                           TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 40),
//                     ElevatedButton(
//                       onPressed: _proceedToTest,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF534F7D),
//                           fixedSize: Size(200, 50)),
//                       child: Text(
//                         'Proceed to Test',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKeys[_currentPage],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'PLATE ${_currentPage + 1}',
//                         style: TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 10,
//                               offset: Offset(0, 5),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset(
//                           'images/plate${_currentPage + 1}.png',
//                           height: 300,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Enter the number you see',
//                         ),
//                         keyboardType: TextInputType.number,
//                         onSaved: (value) {
//                           _answers[_currentPage + 1] = value ?? '';
//                         },
//                         textAlign: TextAlign.center,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a number';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             onPressed: _previousPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                             ),
//                             child: Text(
//                               'Previous',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: _nextPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                             ),
//                             child: Text(
//                               _currentPage < 24 ? 'Next' : 'Submit',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class IshiharaTestPage extends StatefulWidget {
//   const IshiharaTestPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _IshiharaTestPageState createState() => _IshiharaTestPageState();
// }

// class _IshiharaTestPageState extends State<IshiharaTestPage> {
//   final Map<int, String> _answers = {};
//   final List<GlobalKey<FormState>> _formKeys =
//       List.generate(25, (index) => GlobalKey<FormState>());
//   int _currentPage = 0;
//   bool _showDisclaimer = true;

//   final Map<int, List<String>> _results = {
//     1: ['12', '12', '12'],
//     2: ['8', '3', '0'],
//     3: ['6', '5', '0'],
//     4: ['29', '70', '0'],
//     5: ['57', '35', '0'],
//     6: ['5', '2', '0'],
//     7: ['3', '5', '0'],
//     8: ['15', '17', '0'],
//     9: ['74', '21', '0'],
//     10: ['2', '0', '0'],
//     11: ['6', '0', '0'],
//     12: ['97', '0', '0'],
//     13: ['45', '0', '0'],
//     14: ['5', '0', '0'],
//     15: ['7', '0', '0'],
//     16: ['16', '0', '0'],
//     17: ['73', '0', '0'],
//     18: ['0', '5', '0'],
//     19: ['0', '2', '0'],
//     20: ['0', '45', '0'],
//     21: ['0', '73', '0'],
//   };

//   void _nextPage() {
//     if (_currentPage < 24) {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         setState(() {
//           _currentPage++;
//         });
//       }
//     } else {
//       if (_formKeys[_currentPage].currentState?.validate() ?? false) {
//         _formKeys[_currentPage].currentState?.save();
//         if (_answers.length == 25) {
//           _showEndDisclaimer();
//         } else {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Incomplete Test'),
//               content: Text('Please answer all the plates before submitting.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       setState(() {
//         _currentPage--;
//       });
//     }
//   }

//   void _proceedToTest() {
//     setState(() {
//       _showDisclaimer = false;
//     });
//   }

//   void _showEndDisclaimer() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Center(
//           child: Text('DISCLAIMER'),
//         ),
//         content: SingleChildScrollView(
//           child: SizedBox(
//             width: double.minPositive, // Adjust the width as needed
//             child: Center(
//               child: Text(
//                 'NOTE: The results of this test may not be entirely accurate and should not be considered a substitute for professional medical advice. It is always recommended to consult with a qualified healthcare professional for a comprehensive evaluation of your vision.',
//                 textAlign: TextAlign.justify, // Justify the text
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _showResults();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showResults() {
//     String result = _determineResult();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('TEST RESULT'),
//         content: Text(result),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop(); // Go back to the home page
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   String _determineResult() {
//     int normalCount = 0;
//     int redGreenCount = 0;
//     int totalCount = 0;

//     _answers.forEach((plate, answer) {
//       if (_results.containsKey(plate)) {
//         if (answer == _results[plate]![0]) normalCount++;
//         if (answer == _results[plate]![1]) redGreenCount++;
//         if (answer == _results[plate]![2]) totalCount++;
//       }
//     });

//     const threshold = 5;

//     if (normalCount < threshold &&
//         redGreenCount < threshold &&
//         totalCount < threshold) {
//       return 'Result could not be determined';
//     }

//     if (totalCount >= threshold &&
//         totalCount > normalCount &&
//         totalCount > redGreenCount) {
//       return 'Total Colorblindness';
//     }

//     if (redGreenCount >= threshold &&
//         redGreenCount > normalCount &&
//         redGreenCount > totalCount) {
//       if (redGreenCount > (normalCount + totalCount)) {
//         return _determineProtanDeutan();
//       } else {
//         return 'Red-Green Deficiency';
//       }
//     }

//     if (normalCount >= threshold &&
//         normalCount > redGreenCount &&
//         normalCount > totalCount) {
//       return 'Normal Eyesight';
//     }

//     return 'Result could not be determined';
//   }

//   String _determineProtanDeutan() {
//     int protanCount = 0;
//     int deutanCount = 0;

//     final Map<int, List<String>> protanDeutanResults = {
//       22: ['6', '2'],
//       23: ['2', '4'],
//       24: ['5', '3'],
//       25: ['6', '9'],
//     };

//     _answers.forEach((plate, answer) {
//       if (protanDeutanResults.containsKey(plate)) {
//         if (answer == protanDeutanResults[plate]![0]) protanCount++;
//         if (answer == protanDeutanResults[plate]![1]) deutanCount++;
//       }
//     });

//     if (protanCount > deutanCount) {
//       return 'You have Protan Deficiency';
//     } else if (deutanCount > protanCount) {
//       return 'You have Deutan Deficiency';
//     } else {
//       return 'You have Red-Green Blindness but Indeterminate (Protan/Deutan)';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('images/ishiharabar.png', height: 30),
//               SizedBox(width: 10),
//             ],
//           ),
//         ),
//         backgroundColor: Color(0xFF534F7D),
//       ),
//       body: _showDisclaimer
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/ishiharagraphic.png',
//                       height: 150,
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'images/ishiharatext.png',
//                       height: 50,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Welcome to the Ishihara Color Blindness Test! This test is a common method to screen for red-green color blindness. The test consists of a series of plates containing colored dots. If you can clearly see a number hidden within the circle of dots, please enter that number. If you are unable to see a number, simply press "0" and proceed to the next plate.',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Note: Please be aware that the accuracy of this digital test may vary due to factors such as the brightness and color settings of your screen, as well as ambient lighting conditions. For a comprehensive evaluation of your color vision, it is advisable to consult with a qualified healthcare professional and undergo a real Ishihara test.',
//                       style:
//                           TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 40),
//                     ElevatedButton(
//                       onPressed: _proceedToTest,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF534F7D),
//                         fixedSize: Size(200, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         'Proceed to Test',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKeys[_currentPage],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'PLATE ${_currentPage + 1}',
//                         style: TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 10,
//                               offset: Offset(0, 5),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset(
//                           'images/plate${_currentPage + 1}.png',
//                           height: 300,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Enter the number you see',
//                         ),
//                         keyboardType: TextInputType.number,
//                         onSaved: (value) {
//                           _answers[_currentPage + 1] = value ?? '';
//                         },
//                         textAlign: TextAlign.center,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a number';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             onPressed: _previousPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Text(
//                               'Previous',
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: _nextPage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF534F7D),
//                               minimumSize: Size(100, 45),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Text(
//                               _currentPage < 24 ? 'Next' : 'Submit',
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class IshiharaTestPage extends StatefulWidget {
  const IshiharaTestPage({super.key});

  @override
  _IshiharaTestPageState createState() => _IshiharaTestPageState();
}

class _IshiharaTestPageState extends State<IshiharaTestPage> {
  final Map<int, String> _answers = {};
  final List<GlobalKey<FormState>> _formKeys =
      List.generate(21, (index) => GlobalKey<FormState>());
  int _currentPage = 0;
  bool _showDisclaimer = true;

  final Map<int, List<String>> _results = {
    1: ['12', '12', '12'],
    2: ['8', '3', '0'],
    3: ['6', '5', '0'],
    4: ['29', '70', '0'],
    5: ['57', '35', '0'],
    6: ['5', '2', '0'],
    7: ['3', '5', '0'],
    8: ['15', '17', '0'],
    9: ['74', '21', '0'],
    10: ['2', '0', '0'],
    11: ['6', '0', '0'],
    12: ['97', '0', '0'],
    13: ['45', '0', '0'],
    14: ['5', '0', '0'],
    15: ['7', '0', '0'],
    16: ['16', '0', '0'],
    17: ['73', '0', '0'],
    18: ['0', '5', '0'],
    19: ['0', '2', '0'],
    20: ['0', '45', '0'],
    21: ['0', '73', '0'],
  };

  void _nextPage() {
    if (_currentPage < 20) {
      if (_formKeys[_currentPage].currentState?.validate() ?? false) {
        _formKeys[_currentPage].currentState?.save();
        setState(() {
          _currentPage++;
        });
      }
    } else {
      if (_formKeys[_currentPage].currentState?.validate() ?? false) {
        _formKeys[_currentPage].currentState?.save();
        if (_answers.length == 21) {
          _showEndDisclaimer();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Incomplete Test'),
              content: Text('Please answer all the plates before submitting.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _proceedToTest() {
    setState(() {
      _showDisclaimer = false;
    });
  }

  void _showEndDisclaimer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text('DISCLAIMER'),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.minPositive, // Adjust the width as needed
            child: Center(
              child: Text(
                'NOTE: The results of this test may not be entirely accurate and should not be considered a substitute for professional medical advice. It is always recommended to consult with a qualified healthcare professional for a comprehensive evaluation of your vision.',
                textAlign: TextAlign.justify, // Justify the text
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showResults();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showResults() {
    String result = _determineResult();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('TEST RESULT'),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to the home page
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String _determineResult() {
    int normalCount = 0;
    int redGreenCount = 0;
    int totalCount = 0;

    _answers.forEach((plate, answer) {
      if (_results.containsKey(plate)) {
        if (answer == _results[plate]![0]) normalCount++;
        if (answer == _results[plate]![1]) redGreenCount++;
        if (answer == _results[plate]![2]) totalCount++;
      }
    });

    const threshold = 5;

    if (normalCount < threshold &&
        redGreenCount < threshold &&
        totalCount < threshold) {
      return 'Result could not be determined';
    }

    if (totalCount >= threshold &&
        totalCount > normalCount &&
        totalCount > redGreenCount) {
      return 'Total Colorblindness';
    }

    if (redGreenCount >= threshold &&
        redGreenCount > normalCount &&
        redGreenCount > totalCount) {
      if (redGreenCount > (normalCount + totalCount)) {
        return _determineProtanDeutan();
      } else {
        return 'Red-Green Deficiency';
      }
    }

    if (normalCount >= threshold &&
        normalCount > redGreenCount &&
        normalCount > totalCount) {
      return 'Normal Eyesight';
    }

    return 'Result could not be determined';
  }

  String _determineProtanDeutan() {
    int protanCount = 0;
    int deutanCount = 0;

    final Map<int, List<String>> protanDeutanResults = {
      18: ['6', '2'],
      19: ['2', '4'],
      20: ['5', '3'],
      21: ['6', '9'],
    };

    _answers.forEach((plate, answer) {
      if (protanDeutanResults.containsKey(plate)) {
        if (answer == protanDeutanResults[plate]![0]) protanCount++;
        if (answer == protanDeutanResults[plate]![1]) deutanCount++;
      }
    });

    if (protanCount > deutanCount) {
      return 'You have Protan Deficiency';
    } else if (deutanCount > protanCount) {
      return 'You have Deutan Deficiency';
    } else {
      return 'You have Red-Green Blindness but Indeterminate (Protan/Deutan)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF534F7D),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Image.asset(
          'images/ishiharabar.png',
          fit: BoxFit.contain,
          height: 30,
        ),
      ),
      body: _showDisclaimer
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/ishiharagraphic.png',
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'images/ishiharatext.png',
                      height: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to the Ishihara Color Blindness Test! This test is a common method to screen for red-green color blindness. The test consists of a series of plates containing colored dots. If you can clearly see a number hidden within the circle of dots, please enter that number. If you are unable to see a number, simply press "0" and proceed to the next plate.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Note: Please be aware that the accuracy of this digital test may vary due to factors such as the brightness and color settings of your screen, as well as ambient lighting conditions. For a comprehensive evaluation of your color vision, it is advisable to consult with a qualified healthcare professional and undergo a real Ishihara test.',
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _proceedToTest,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF534F7D),
                          fixedSize: Size(200, 50)),
                      child: Text(
                        'Proceed to Test',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKeys[_currentPage],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PLATE ${_currentPage + 1}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'images/plate${_currentPage + 1}.png',
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter the number you see',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _answers[_currentPage + 1] = value ?? '';
                        },
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _previousPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF534F7D),
                              minimumSize: Size(100, 45),
                            ),
                            child: Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF534F7D),
                              minimumSize: Size(100, 45),
                            ),
                            child: Text(
                              _currentPage < 20 ? 'Next' : 'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

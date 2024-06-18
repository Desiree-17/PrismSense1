// import 'package:flutter/material.dart';
// import 'achromatopsia.dart';
// import 'deuteranopia.dart';
// import 'protanopia.dart';
// import 'tritanopia.dart';

// class FilterPage extends StatelessWidget {
//   const FilterPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filter Page'),
//         backgroundColor: const Color(0xFF534F7D),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 0.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _applyFilter(context, 'Protanopia');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.zero,
//                     ),
//                   ),
//                   child: Container(
//                     height: 100,
//                     width: 300,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF534F7D),
//                       borderRadius: BorderRadius.zero,
//                     ),
//                     child: const Text(
//                       'Protanopia',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     _applyFilter(context, 'Deuteranopia');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.zero,
//                     ),
//                   ),
//                   child: Container(
//                     height: 100,
//                     width: 300,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF534F7D),
//                       borderRadius: BorderRadius.zero,
//                     ),
//                     child: const Text(
//                       'Deuteranopia',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     _applyFilter(context, 'Tritanopia');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.zero,
//                     ),
//                   ),
//                   child: Container(
//                     height: 100,
//                     width: 300,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF534F7D),
//                       borderRadius: BorderRadius.zero,
//                     ),
//                     child: const Text(
//                       'Tritanopia',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     _applyFilter(context, 'Achromatopsia');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.zero,
//                     ),
//                   ),
//                   child: Container(
//                     height: 100,
//                     width: 300,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF534F7D),
//                       borderRadius: BorderRadius.zero,
//                     ),
//                     child: const Text(
//                       'Achromatopsia',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _applyFilter(BuildContext context, String filterType) {
//     switch (filterType) {
//       case 'Protanopia':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProtanopiaPage(),
//           ),
//         );
//         break;
//       case 'Deuteranopia':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DeuteranopiaPage(),
//           ),
//         );
//         break;
//       case 'Tritanopia':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TritanopiaPage(),
//           ),
//         );
//         break;
//       case 'Achromatopsia':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AchromatopsiaPage(),
//           ),
//         );
//         break;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'achromatopsia.dart';
import 'deuteranopia.dart';
import 'protanopia.dart';
import 'tritanopia.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/appbarlogo4.png',
          fit: BoxFit.contain,
          height: 27,
        ),
        backgroundColor: const Color(0xFF534F7D),
        iconTheme: IconThemeData(color: Colors.white),
        // Change back button color to white
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'images/bg6.png', // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
            // Foreground content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  const Text(
                    'CHOOSE A TYPE OF COLORBLINDNESS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              _applyFilter(context, 'Protanopia');
                            },
                            label: 'Protanopia',
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedButton(
                            onPressed: () {
                              _applyFilter(context, 'Deuteranopia');
                            },
                            label: 'Deuteranopia',
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedButton(
                            onPressed: () {
                              _applyFilter(context, 'Tritanopia');
                            },
                            label: 'Tritanopia',
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedButton(
                            onPressed: () {
                              _applyFilter(context, 'Achromatopsia');
                            },
                            label: 'Achromatopsia',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilter(BuildContext context, String filterType) {
    switch (filterType) {
      case 'Protanopia':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProtanopiaPage(),
          ),
        );
        break;
      case 'Deuteranopia':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeuteranopiaPage(),
          ),
        );
        break;
      case 'Tritanopia':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TritanopiaPage(),
          ),
        );
        break;
      case 'Achromatopsia':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AchromatopsiaPage(),
          ),
        );
        break;
    }
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double borderRadius;
  final double elevation;

  const CustomElevatedButton({
    required this.onPressed,
    required this.label,
    this.borderRadius = 15.0, // Default border radius
    this.elevation = 10.0, // Default shadow elevation
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Container(
        height: 100,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF534F7D),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: elevation,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/filter.dart';
// import 'camera.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: [
//             Image.asset(
//               'images/bg1.png',
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//             const Center(
//               child: MenuScreen(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'images/icon.png',
//                 height: 350,
//               ),
//               const SizedBox(height: 30),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CameraPage(),
//                         ),
//                       );
//                     },
//                     icon:
//                         const Icon(Icons.camera, size: 30, color: Colors.white),
//                     label: const Text(
//                       'Live Camera',
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF534F7D),
//                       minimumSize: const Size(300, 100),
//                       padding: const EdgeInsets.all(20),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const FilterPage(),
//                         ),
//                       );
//                     },
//                     icon:
//                         const Icon(Icons.filter, size: 30, color: Colors.white),
//                     label: const Text(
//                       'Colorblind Simulator',
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF534F7D),
//                       minimumSize: const Size(300, 100),
//                       padding: const EdgeInsets.all(20),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // Navigation to History page
//                     },
//                     icon: const Icon(Icons.history,
//                         size: 30, color: Colors.white),
//                     label: const Text(
//                       'History',
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF534F7D),
//                       minimumSize: const Size(300, 100),
//                       padding: const EdgeInsets.all(20),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/filter.dart';
import 'camera.dart';
// import 'history.dart'; // Import the HistoryPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          'images/logoonly.png',
          height: 800,
        ),
        nextScreen: const MainScreen(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          const Center(
            child: MenuScreen(),
          ),
        ],
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/icon.png',
                height: 400,
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.camera,
                        size: 30, color: Colors.white), // Icon color white
                    label: 'Live Camera',
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter,
                        size: 30, color: Colors.white), // Icon color white
                    label: 'Colorblind Simulator',
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const HistoryPage(),
                      //   ),
                      // );
                    },
                    icon: const Icon(Icons.history,
                        size: 30, color: Colors.white), // Icon color white
                    label: 'Added Feature',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  const CustomElevatedButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Fixed width
      height: 100, // Fixed height
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white, // Set text color to white
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF534F7D),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Adjust border radius here
          ),
          elevation: 20, // Adjust the shadow strength
          shadowColor: Colors.black.withOpacity(0.5), // Shadow color
        ),
      ),
    );
  }
}
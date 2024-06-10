// // ignore_for_file: prefer_const_constructors
// import 'package:flutter/material.dart';
// import 'main.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen>
//     with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }

//   void _nextPage() {
//     if (_currentPage < 2) {
//       setState(() {
//         _currentPage++;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         );
//       });
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _fadeAnimation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Scaffold(
//             body: Stack(
//               children: [
//                 // Background images
//                 PageView(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentPage = index;
//                     });
//                   },
//                   children: [
//                     _buildPage('images/first.png'),
//                     _buildPage('images/second.png'),
//                     _buildPage('images/third.png'),
//                   ],
//                 ),
//                 // Skip button
//                 Positioned(
//                   top: 40,
//                   right: 20,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => MainScreen()),
//                       );
//                     },
//                     icon: Icon(Icons.close),
//                     color: Color(0xFF534F7D),
//                     iconSize: 30,
//                   ),
//                 ),
//                 // Pagination dots and Next/Get Started button
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             3,
//                             (index) => AnimatedContainer(
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.easeInOut,
//                               margin: EdgeInsets.symmetric(horizontal: 8),
//                               width: _currentPage == index ? 20 : 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF534F7D),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: _nextPage,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF534F7D),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 20, horizontal: 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: Text(
//                             _currentPage == 2 ? 'GET STARTED' : 'Next',
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPage(String assetPath) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(assetPath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

// // ignore_for_file: prefer_const_constructors
// import 'package:flutter/material.dart';
// import 'main.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen>
//     with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _nextPage() {
//     if (_currentPage < 2) {
//       setState(() {
//         _currentPage++;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         );
//       });
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background images
//           PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             children: [
//               _buildPage('images/first.png'),
//               _buildPage('images/second.png'),
//               _buildPage('images/third.png'),
//             ],
//           ),
//           // Skip button
//           Positioned(
//             top: 40,
//             right: 20,
//             child: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => MainScreen()),
//                 );
//               },
//               icon: Icon(Icons.close),
//               color: Color(0xFF534F7D),
//               iconSize: 30,
//             ),
//           ),
//           // Pagination dots and Next/Get Started button
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       3,
//                       (index) => AnimatedContainer(
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeInOut,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         width: _currentPage == index ? 20 : 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF534F7D),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _nextPage,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF534F7D) ,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       _currentPage == 2 ? 'GET STARTED' : 'Next',
//                       style: TextStyle(
//                         fontSize: 18,
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

//   Widget _buildPage(String assetPath) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(assetPath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background images
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage('images/first.png'),
              _buildPage('images/second.png'),
              _buildPage('images/third.png'),
            ],
          ),
          // Skip button
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              icon: Icon(Icons.close),
              color: Color(0xFF534F7D),
              iconSize: 30,
            ),
          ),
          // Pagination dots and Next/Get Started button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: _currentPage == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Color(0xFF534F7D),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF534F7D),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _currentPage == 2 ? 'GET STARTED' : 'Next',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Set the text color to white
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

  Widget _buildPage(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

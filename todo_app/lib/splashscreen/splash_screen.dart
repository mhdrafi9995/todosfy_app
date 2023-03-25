// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:todo_app/Screens/home.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => Home(),
//       ));
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 30.0),
//             child: Image.asset(
//               "lib/assets/images/todoSplashScreen.png",
//               height: 150,
//             ),
//           ),
//           const Center(
//             child: Text(
//               'ToDo',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 32,
//                   color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

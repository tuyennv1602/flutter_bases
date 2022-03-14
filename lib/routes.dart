// import 'package:flutter_base/application.dart';
// import 'package:flutter_base/features/splash/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// var bootStage = 1;

// RouteFactory routes({@required Application application}) {
//   return (RouteSettings settings) {
//     var fullScreen = false;
//     Widget screen;

//     if (bootStage == 1) {
//       bootStage = 2;
//       return PageRouteBuilder(
//         pageBuilder: (_, __, ___) => FlashScreen(),
//       );
//     }
//     final agruments = settings.arguments as Map<String, dynamic> ?? {};
//     switch (settings.name) {
//       case HomeScreen.route:
//         screen = HomeScreen();
//         break;
//       case SignInScreen.route:
//         fullScreen = true;
//         screen = SignInScreen();
//     }

//     if (bootStage == 2) {
//       bootStage = 3;

//       return PageRouteBuilder(
//         pageBuilder: (BuildContext context, _, __) {
//           return screen;
//         },
//         transitionDuration: const Duration(milliseconds: 500),
//       );
//     }

//     if (fullScreen) {
//       return MaterialPageRoute(
//         builder: (_) => screen,
//         fullscreenDialog: true,
//       );
//     }

//     return PageRouteBuilder(
//         pageBuilder: (BuildContext context, _, __) {
//           return screen;
//         },
//         transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//           return FadeTransition(opacity: animation, child: child);
//         }
//     );
//   };
// }

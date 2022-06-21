import 'package:flutter/material.dart';
import 'package:flutter_base/core_packages.dart';

Widget splashScreenBuilder(BuildContext context) => const SplashScreen();

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 100,
            ),
            ElevatedButton(
              onPressed: () {
                context.navigator.toHome();
              },
              child: const Text('Platforn'),
            ),
            ElevatedButton(
              onPressed: () {
                context.navigator.slideUpToHome();
              },
              child: const Text('Slide Up'),
            ),
            ElevatedButton(
              onPressed: () {
                context.navigator.fadeToHome();
              },
              child: const Text('Fade'),
            ),
            ElevatedButton(
              onPressed: () {
                context.navigator.scaleToHome();
              },
              child: const Text('Scale'),
            ),
            ElevatedButton(
              onPressed: () {
                context.navigator.callback(() {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Yay! A SnackBar!'),
                  ));
                });
              },
              child: const Text('Callback'),
            ),
          ],
        ),
      ),
    );
  }
}

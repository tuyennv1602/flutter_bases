import 'package:flutter/material.dart';

Widget homeScreenBuilder(
  BuildContext context, {
  VoidCallback? onRefresh,
}) =>
    HomeScreen(
      onRefresh: onRefresh,
    );

class HomeScreen extends StatefulWidget {
  final VoidCallback? onRefresh;
  const HomeScreen({
    Key? key,
    this.onRefresh,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onRefresh?.call();
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

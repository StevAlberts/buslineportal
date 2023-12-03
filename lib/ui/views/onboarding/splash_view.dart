import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static String get routeName => 'splash';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/busline-logo.png",
                  height: 200,
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Busline Portal",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                context.go(SplashView.routeLocation);
              },
              child: const Text("Go Home"),
            ),
          ],
        ),
      ),
    );
  }
}

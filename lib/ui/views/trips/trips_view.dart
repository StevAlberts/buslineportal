import 'package:flutter/material.dart';

class TripsView extends StatelessWidget {
  const TripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Journeys / Trips",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Center(
        child: Text("Trips", style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}

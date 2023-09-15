import 'package:flutter/material.dart';

class TripReportsView extends StatelessWidget {
  const TripReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Journeys / Reports",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Center(
        child: Text("Reports", style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}

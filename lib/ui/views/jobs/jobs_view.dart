import 'package:flutter/material.dart';

class JobsView extends StatelessWidget {
  const JobsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Center(
        child: Text("Jobs", style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}

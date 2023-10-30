import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double paddingValue;
    //
    // if (screenWidth < 600) {
    //   // For smaller screens
    //   paddingValue = 16.0;
    // } else if (screenWidth < 1200) {
    //   // For medium-sized screens
    //   paddingValue = 32.0;
    // } else {
    //   // For larger screens
    //   paddingValue = 48.0;
    // }

    double paddingValue() {
      double val;
      if (screenWidth < 600) {
        // For smaller screens
        val = 8.0;
      } else if (screenWidth < 1200) {
        // For medium-sized screens
        val = 70.0;
      } else {
        // For larger screens
        val = screenWidth*0.2;
      }
      return val;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingValue()),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Employees"),
              subtitle: const Text("Manage and create employee tasks"),
              trailing: FilledButton(
                onPressed: () {
                  context.go('/employees');
                },
                child: const Text("View"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus_sharp),
              title: const Text("Journeys"),
              subtitle: const Text("Create trips and manage reports"),
              trailing: FilledButton(
                onPressed: () {
                  context.go('/journeys');
                },
                child: const Text("View"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text("Inventory"),
              subtitle: const Text("Manage bus fleet, routes and more"),
              trailing: FilledButton(
                onPressed: () {
                  context.go("/inventories");
                },
                child: const Text("View"),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Current trips",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: const Text("Trip name"),
                subtitle: const Text("destination"),
                trailing: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  context.go("/journey_details");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:buslineportal/shared/utils/dynamic_padding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
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
                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${(index + 1) * 21}"),
                    ),
                    const Icon(Icons.event_seat),
                  ],
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

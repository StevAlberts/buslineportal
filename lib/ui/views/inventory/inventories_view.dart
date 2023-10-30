import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InventoriesView extends StatelessWidget {
  const InventoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventories"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Routes"),
            subtitle: const Text("Create and manage routes"),
            trailing: FilledButton(
              onPressed: () {},
              child: const Text("New Route"),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => ListTile(
              title: const Text("Route name"),
              subtitle: const Text("Stage name"),
              onTap: () {
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Bus Fleet"),
            subtitle: const Text("Create and manage bus fleet"),
            trailing: FilledButton(
              onPressed: () {},
              child: const Text("New Bus"),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(),
              title: const Text("Model name"),
              subtitle: Text("200$index"),
              trailing:Text("${(index+1)*21} seats") ,
              onTap: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}

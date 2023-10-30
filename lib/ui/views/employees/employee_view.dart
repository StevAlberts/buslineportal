import 'package:flutter/material.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees List"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.lightBlue),
              icon: const Icon(Icons.add),
              onPressed: () {},
              label: const Text("New employee"),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Your names"),
            subtitle: Text("example@email.com"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(),
              title: const Text("Employee name"),
              subtitle: const Text("example@email.com"),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("Role"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

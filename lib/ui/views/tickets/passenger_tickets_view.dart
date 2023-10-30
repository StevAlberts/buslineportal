import 'package:flutter/material.dart';

class PassengerTicketsView extends StatelessWidget {
  const PassengerTicketsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger tickets"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "UGX 2,310,000",
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 78,
        itemBuilder: (context, index) => ListTile(
          title: const Text("Passenger names"),
          subtitle: const Text("destination"),
          trailing: const Text("UGX 23,000"),
          onTap: () {},
        ),
      ),
    );
  }
}

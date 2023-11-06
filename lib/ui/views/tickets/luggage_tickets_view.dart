import 'package:flutter/material.dart';

import '../../../shared/utils/dynamic_padding.dart';

class LuggageTicketsView extends StatelessWidget {
  const LuggageTicketsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Luggage tickets"),
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
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
        itemBuilder: (context, index) => ListTile(
          leading: const CircleAvatar(),
          title: const Text("Destination"),
          subtitle: const Text("details of the luggage goes here"),
          trailing: const Text("UGX 12,000"),
          onTap: () {},
        ),
      ),
    );
  }
}

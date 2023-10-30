import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart' as pdf;

class JourneyDetailsView extends StatelessWidget {
  const JourneyDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journey destination"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.circle,
                color: Colors.green,
              ),
            ),
            title: Text(
              "Journey Status",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: Text(
              "STARTED",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Trip Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.directions_bus_filled_sharp),
            ),
            title: Text(
              "UAB 123X",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              "Model make 2000",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on),
                  ),
                  title: Text(
                    "From",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    "City A",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    "To Destination",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    "City B",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.alarm),
            ),
            title: Text(
              "Departure Time",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              "Thur 3/7/2023 @ 12:00 PM",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.timelapse),
            ),
            title: Text(
              "Arrival Time",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              "Thur 3/7/2023 @ 18:25 PM",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Text("5 hours"),
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Tickets",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.money),
            ),
            title: Text(
              "Passengers Tickets",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: const Text(
              "Tap to view list of passengers",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.go("/passengers");
            },
          ),
          ListTile(
            enabled: true,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.money),
            ),
            title: Text(
              "Luggage Tickets",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: const Text(
              "Tap to view list of luggage",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.go("/luggage");
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.description),
            ),
            title: const Text(
              "Generate report",
            ),
            subtitle: const Text(
              "A summary of ticket sales and purchases",
            ),
            trailing:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                icon: const Icon(Icons.print),
                onPressed: (){
                  context.go("/report");
                },
                label: const Text("Generate"),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Incidence Reports",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => const ListTile(
              leading: Text("23"),
              title: Text("Incidence details"),
              subtitle: Text("Destination"),
              trailing: Text("UGX 20,000"),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Staff Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(),
              title: const Text("Employee name"),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("Role"),
              ),
            ),
          ),
          const Divider(),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: BarcodeWidget(
          //       barcode: Barcode.code128(escapes: true),
          //       data: "Hello World",
          //       width: 200,
          //       height: 100,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

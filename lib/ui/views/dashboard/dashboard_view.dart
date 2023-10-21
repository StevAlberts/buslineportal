import 'package:buslineportal/data/dummy_data.dart';
import 'package:buslineportal/ui/widgets/copyright.dart';
import 'package:buslineportal/ui/widgets/page_title.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const PageTitle(title: "Dashboard"),
            Row(
              children: [
                DashboardCard(
                  title: 'Scheduled Trips',
                  value: '100',
                  description: '12 routes & 13 buses',
                  buttonText: 'Schedule Trip',
                  buttonAction: () {},
                ),
                const Spacer(),
                DashboardCard(
                  title: 'Active Trips',
                  value: '100',
                  description: '100 trips in total',
                  buttonText: 'View All',
                  buttonAction: () {},
                ),
                const Spacer(),
                DashboardCard(
                  title: 'Completed Trips',
                  value: '100',
                  description: '100 trips completed',
                  buttonText: 'Reports',
                  buttonAction: () {},
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                      ),
                      // horizontal line
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        height: 2,
                        width: 150,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.schedule_outlined),
                        label: Text("Schedule Trip",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.drive_eta_rounded),
                        label: Text("Assign Driver",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.bus_alert_sharp),
                        label: Text("Book Trip",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Recent Trips",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Table(
              children: [
                const TableRow(
                  children: [
                    DashboardTableCell(text: "#"),
                    DashboardTableCell(text: "Date"),
                    DashboardTableCell(text: "Bus No."),
                    DashboardTableCell(text: "Route Name"),
                    DashboardTableCell(text: "Departure Time"),
                    DashboardTableCell(text: "Capacity (Seats)"),
                    DashboardTableCell(text: "Actions"),
                  ],
                ),
                for (var trip in dummyTrips)
                  TableRow(
                    children: [
                      DashboardTableCell(text: trip['id']),
                      DashboardTableCell(text: trip['date'].toString()),
                      DashboardTableCell(text: trip['busNumber']),
                      DashboardTableCell(text: trip['route']),
                      DashboardTableCell(
                          text: trip['departureTime'].toString()),
                      DashboardTableCell(text: trip['capacity'].toString()),
                      TableCell(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),
            const Spacer(),
            const Copyright()
          ],
        ),
      ),
    );
  }
}

class DashboardTableCell extends StatelessWidget {
  const DashboardTableCell({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.description,
    required this.buttonText,
    required this.buttonAction,
  });

  final String title;
  final String value;
  final String description;
  final String buttonText;

  final void Function() buttonAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 200,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                  ),
                  TextButton(
                    onPressed: buttonAction,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

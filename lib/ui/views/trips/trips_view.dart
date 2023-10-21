import 'package:buslineportal/data/dummy_data.dart';
import 'package:buslineportal/ui/widgets/copyright.dart';
import 'package:buslineportal/ui/widgets/page_title.dart';
import 'package:buslineportal/ui/widgets/table_body.dart';
import 'package:buslineportal/ui/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var formatDate = DateFormat("dd-MM-yyyy");
var formatTime = DateFormat("hh:mm a");

class TripsView extends StatefulWidget {
  const TripsView({Key? key}) : super(key: key);

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    void _openAddTrip() {
      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (ctx) => const NewTrip(),
        isScrollControlled: true,
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const PageTitle(title: "Trips"),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _openAddTrip,
                  icon: const Icon(Icons.add_outlined),
                  label: const Text("Add Trip"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                  children: const [
                    TableHeader(text: "#"),
                    TableHeader(text: "Date"),
                    TableHeader(text: "Driver"),
                    TableHeader(text: "Bus"),
                    TableHeader(text: "Route"),
                    TableHeader(text: "Status"),
                    TableHeader(text: "Departure Time"),
                    TableHeader(text: "Arrival Time"),
                    TableHeader(text: "Capacity (seats)"),
                    TableHeader(text: "Est. Duration"),
                    TableHeader(text: "Actions"),
                  ],
                ),
                for (var trip in dummyTripsData)
                  TableRow(
                    children: [
                      TableBody(text: trip["id"]),
                      TableBody(
                        text: formatDate.format(
                          trip["date"],
                        ),
                      ),
                      TableBody(text: trip["driver"]),
                      TableBody(text: trip["bus"]),
                      TableBody(text: trip["route"]),
                      if (trip["status"] == "Completed")
                        TableBody(
                          text: trip["status"],
                          color: Colors.green,
                        )
                      else if (trip["status"] == "In Progress")
                        TableBody(
                          text: trip["status"],
                          color: Colors.orange,
                        )
                      else
                        TableBody(text: trip["status"]),
                      TableBody(
                        text: formatTime.format(
                          trip["departureTime"],
                        ),
                      ),
                      TableBody(
                        text: formatTime.format(
                          trip["arrivalTime"],
                        ),
                      ),
                      TableBody(text: trip["capacity"].toString()),
                      TableBody(text: trip["duration"]),
                      TableCell(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

class NewTrip extends StatefulWidget {
  const NewTrip({Key? key}) : super(key: key);

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  final _route = dummyRoutes.first;
  final _driver = TextEditingController();
  final _bus = TextEditingController();
  final _capacity = TextEditingController();
  final _departureTime = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickDate;
    });
  }

  @override
  void dispose() {
    _driver.dispose();
    _bus.dispose();
    _capacity.dispose();
    _departureTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle(
                title: "Add a Trip",
              ),
              const SizedBox(height: 20),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width * 0.5,
                initialSelection: _route,
                onSelected: (value) => {},
                dropdownMenuEntries: dummyRoutes.map<DropdownMenuEntry<String>>(
                  (String route) {
                    return DropdownMenuEntry<String>(
                        label: route, value: route);
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

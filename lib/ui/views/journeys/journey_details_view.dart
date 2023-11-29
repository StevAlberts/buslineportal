import 'package:buslineportal/shared/utils/app_color_utils.dart';
import 'package:buslineportal/shared/utils/app_strings_utils.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:buslineportal/ui/views/tickets/luggage_tickets_view.dart';
import 'package:buslineportal/ui/views/tickets/passenger_tickets_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/models/trip_model.dart';
import '../../../shared/utils/dynamic_padding.dart';

class JourneyDetailsView extends StatelessWidget {
  const JourneyDetailsView({Key? key, required this.trip}) : super(key: key);

  final Trip? trip;

  @override
  Widget build(BuildContext context) {
    // final trips = GoRouterState.of(context).extra as List<Trip>?;
    //
    // var trip = trips.where((element) => element.id == trip.id)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(trip != null
            ? "Trip ${trip?.id.toUpperCase()}"
            : ""),
      ),
      body: trip != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderSwitch(
                    name: 'status',
                    // enabled: trip != null,
                    enabled: false,
                    initialValue:
                        journeyStatusStarted(trip!.isStarted, trip!.isEnded),
                    decoration: const InputDecoration(
                      labelText: 'Journey Status',
                      hintText: "Change journey status",
                    ),
                    title: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: journeyStatusColors(
                            trip!.isStarted,
                            trip!.isEnded,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          journeyStatusText(
                            trip!.isStarted,
                            trip!.isEnded,
                          ),
                        ),
                      ],
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.directions_bus_filled_sharp),
                  ),
                  title: Text(
                    "Travel Date",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    travelDateFormat(trip!.travelDate),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${trip?.bus.licence.toUpperCase()}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    "Trip Details",
                    style: Theme.of(context).textTheme.titleLarge,
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
                          "${trip?.startDest.toUpperCase()}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.location_off),
                        ),
                        title: Text(
                          "To",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          "${trip?.endDest.toUpperCase()}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: trip!.isStarted,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.play_circle),
                        ),
                        title: Text(
                          "Start Activity",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          travelDateFormat(trip!.departure),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.stop_circle),
                        ),
                        title: Text(
                          "End Activity",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          trip?.arrival != null
                              ? travelDateFormat(trip!.arrival)
                              : "---",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Visibility(
                  visible: trip!.isStarted,
                  child: Column(
                    children: [
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PassengerTicketsView(tripId: trip!.id)));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LuggageTicketsView(tripId: trip!.id)));
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
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.green),
                            icon: const Icon(Icons.print),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Coming soon...")),
                              );
                            },
                            label: const Text("Generate"),
                          ),
                        ),
                      ),
                      // const Divider(),
                      // ListTile(
                      //   title: Text(
                      //     "Incidence Reports",
                      //     style: Theme.of(context).textTheme.titleLarge,
                      //   ),
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount: 3,
                      //   itemBuilder: (context, index) => const ListTile(
                      //     leading: Text("23"),
                      //     title: Text("Incidence details"),
                      //     subtitle: Text("Destination"),
                      //     trailing: Text("UGX 20,000"),
                      //   ),
                      // ),
                      const Divider(),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Staff Information",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trip?.staffDetails.length,
                  itemBuilder: (context, index) {
                    var staff = trip!.staffDetails[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: TextAvatar(
                          text: '${staff.firstName} ${staff.lastName}'
                              .toUpperCase(),
                          shape: Shape.Circular,
                          numberLetters: 2,
                          upperCase: true,
                        ),
                      ),
                      title: Text("${staff.firstName} ${staff.lastName}"),
                      subtitle: Text("ID ${staff.staffId}"),
                      trailing: Card(
                        color: roleCardColor(staff.role!),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(staff.role!.toUpperCase()),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sorry, No details",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please click on a journey to view its trip details",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.go("/");
                      },
                      child: const Text("Go Back"),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

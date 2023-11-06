import 'package:barcode_widget/barcode_widget.dart';
import 'package:buslineportal/shared/utils/app_color_utils.dart';
import 'package:buslineportal/shared/utils/app_strings_utils.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart' as pdf;

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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingBarWidth(context)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
              ),
              Text(trip != null
                  ? "Journey ID ${trip?.id.toUpperCase()}"
                  : "Journey destination"),
            ],
          ),
        ),
      ),
      body: trip != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
              children: [
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: journeyStatusColors(
                        trip!.isStarted,
                        trip?.departure == null,
                      ),
                    ),
                  ),
                  title: Text(
                    "Travel Date",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    travelDateFormat(trip!.travelDate),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: Text(
                    journeyStatusText(
                      trip!.isStarted,
                      trip?.departure == null,
                    ),
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
                    "${trip?.bus.licence.toUpperCase()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "${trip?.bus.capacity} Seats",
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
                          "${trip?.startDest.toUpperCase()}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
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
                          child: Icon(Icons.alarm),
                        ),
                        title: Text(
                          "Departure Time",
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
                          child: Icon(Icons.timelapse),
                        ),
                        title: Text(
                          "Arrival Time",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          travelDateFormat(trip!.departure),
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
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.green),
                            icon: const Icon(Icons.print),
                            onPressed: () {
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

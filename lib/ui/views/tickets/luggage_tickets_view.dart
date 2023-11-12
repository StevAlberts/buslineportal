import 'package:buslineportal/shared/providers/tickets/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/passengers/passengers_provider.dart';
import '../../../shared/providers/trips/trips_provider.dart';
import '../../../shared/utils/dynamic_padding.dart';

class LuggageTicketsView extends ConsumerWidget {
  const LuggageTicketsView( {Key? key, required this.tripId,}) : super(key: key);

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamTrip = ref.watch(streamTripProvider(tripId));
    final streamPassengerTickets =
    ref.watch(streamLuggageTicketsProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Luggage Tickets"),
      ),

      body: streamPassengerTickets.when(
        data: (tickets) {
          return tickets.isNotEmpty
              ? ListView.separated(
            itemCount: tickets.length,
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              var passenger = tickets.elementAt(index);
              return ListTile(
                tileColor: index % 2 == 0
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    passenger.senderNames,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                title: Row(
                  children: [
                    Text(passenger.receiverNames),
                    const SizedBox(
                      width: 8.0,
                    ),
                    // passenger.isValid
                    //     ? const Icon(
                    //         Icons.verified,
                    //         size: 20,
                    //         color: Colors.blue,
                    //       )
                    //     : const SizedBox(),
                  ],
                ),
                subtitle: Text(passenger.toDest),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("UGX ${passenger.fare}"),
                  ],
                ),
                onTap: () {},
              );
            },
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.receipt_long_outlined, size: 100),
              ),
              Center(
                child: Text(
                  "No tickets available.",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
        error: (error, stack) {
          print(error);
          print(stack);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Failed to get trip. Please try again.",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$error",
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

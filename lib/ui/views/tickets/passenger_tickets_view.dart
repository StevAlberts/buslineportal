import 'package:buslineportal/shared/providers/tickets/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/utils/dynamic_padding.dart';

class PassengerTicketsView extends ConsumerWidget {
  const PassengerTicketsView({Key? key, required this.tripId}) : super(key: key);
  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamPassengerTickets =
    ref.watch(streamPassengerTicketsProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger Tickets"),
      ),

      body: streamPassengerTickets.when(
        data: (tickets) {
          return tickets.isNotEmpty
              ? ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),

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
                    passenger.seatNo,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                title: Row(
                  children: [
                    Text(passenger.names),
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
                subtitle: Text("${passenger.fromDest.toUpperCase()} -to- ${passenger.toDest.toUpperCase()}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("UGX ${passenger.fare}"),
                    const SizedBox(width: 8),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: passenger.isBoarded
                            ? passenger.isExit
                            ? Colors.red
                            : Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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


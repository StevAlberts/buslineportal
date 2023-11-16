import 'package:buslineportal/shared/providers/tickets/tickets_provider.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/passengers/passengers_provider.dart';
import '../../../shared/providers/trips/trips_provider.dart';
import '../../../shared/utils/dynamic_padding.dart';

class LuggageTicketsView extends ConsumerWidget {
  const LuggageTicketsView({
    Key? key,
    required this.tripId,
  }) : super(key: key);

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
                  padding:
                      EdgeInsets.symmetric(horizontal: paddingWidth(context)),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.1,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    var luggageTicket = tickets.elementAt(index);
                    return ExpansionTile(
                      collapsedBackgroundColor: index % 2 == 0
                          ? Colors.grey.withOpacity(0.1)
                          : Colors.transparent,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          luggageTicket.id,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      title: Text(luggageTicket.receiverNames),
                      subtitle: Text(luggageTicket.toDest.toUpperCase()),
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Receiver'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(luggageTicket.receiverNames),
                              const SizedBox(height: 8.0,),
                              Text(luggageTicket.receiverContact),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(luggageTicket.receiverContact),
                          ),
                        ),
                        // const Divider(),
                        ListTile(
                          leading: const Icon(Icons.person_2),
                          title: const Text('Sender'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(luggageTicket.senderNames),
                              const SizedBox(height: 8.0,),
                              Text(luggageTicket.senderContact),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(luggageTicket.receiverContact),
                          ),
                        ),
                        // const Divider(),
                        ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: const Text('Description'),
                          subtitle: Text(luggageTicket.description),
                        ),
                        ListTile(
                          leading: const Icon(Icons.money),
                          title: const Text('Fare'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${luggageTicket.fare}', style: Theme.of(context).textTheme.bodyLarge,),
                              SizedBox(height: 4),
                              Text('Served By ${luggageTicket.staffId.toUpperCase()} on ${travelDateFormat(luggageTicket.timestamp)}',
                              style: Theme.of(context).textTheme.bodyMedium,),
                            ],
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.image),
                          title: Text('Luggage Images'),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: luggageTicket.imgUrls.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Image.network(luggageTicket.imgUrls[index]),
                            ),
                          ),
                        ),

                      ],
                    );
                    // return ListTile(
                    //   tileColor: index % 2 == 0
                    // ? Colors.grey.withOpacity(0.1)
                    // : Colors.transparent,
                    // leading: Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     luggageTicket.id,
                    //     style: Theme.of(context).textTheme.titleMedium,
                    //   ),
                    // ),
                    //   title: Row(
                    //     children: [
                    //       Text(luggageTicket.receiverNames),
                    //       const SizedBox(
                    //         width: 8.0,
                    //       ),
                    //       // luggageTicket.isValid
                    //       //     ? const Icon(
                    //       //         Icons.verified,
                    //       //         size: 20,
                    //       //         color: Colors.blue,
                    //       //       )
                    //       //     : const SizedBox(),
                    //     ],
                    //   ),
                    //   subtitle: Text(luggageTicket.toDest.toUpperCase()),
                    //   trailing: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text("UGX ${luggageTicket.fare}"),
                    //     ],
                    //   ),
                    //   onTap: () {},
                    // );
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

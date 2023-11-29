import 'package:buslineportal/shared/providers/tickets/tickets_provider.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:octo_image/octo_image.dart';

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
        centerTitle: true,
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
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(luggageTicket.receiverContact),
                            ],
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
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(luggageTicket.senderContact),
                            ],
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
                              Text(
                                '${luggageTicket.fare}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Served By ${luggageTicket.staffId.toUpperCase()} on ${travelDateFormat(luggageTicket.timestamp)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: OctoImage(
                                image: NetworkImage(
                                  luggageTicket.imgUrls[index],
                                ),
                                placeholderBuilder:
                                    OctoPlaceholder.circularProgressIndicator(),
                                errorBuilder: OctoError.icon(color: Colors.red),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              // child: OctoImage(
                              //   image: CachedNetworkImageProvider(
                              //       luggageTicket.imgUrls[index]),
                              //   placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                              //   errorBuilder: OctoError.icon(color: Colors.red),
                              //   fit: BoxFit.cover,
                              // ),
                              // child: Image.network(
                              //   // luggageTicket.imgUrls[index],
                              //   "https://firebasestorage.googleapis.com/v0/b/secrets-anon.appspot.com/o/secrets-media%2Fimg_5ov91voVLur9xywde6MTTq.jpg?alt=media&token=f47a9f90-7d89-4e6c-8257-79baa822c65c",
                              //   height: 100,
                              //   width: 100,
                              // ),
                              // child:img.Image(  height: 100,
                              //     width: 100,
                              //     image: ImageProvider("https://firebasestorage.googleapis.com/v0/b/buslinego.appspot.com/o/images%2Fkampala%2F280426%20(0).jpg?alt=media&token=81368280-9395-4613-97c4-7502c6cd27e3"),
                              // ),
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

import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/models/user_model.dart';
import 'package:buslineportal/shared/providers/company/company_provider.dart';
import 'package:buslineportal/shared/providers/trips/trips_provider.dart';
import 'package:buslineportal/shared/providers/users/user_provider.dart';
import 'package:buslineportal/shared/utils/dynamic_padding.dart';
import 'package:buslineportal/ui/views/employees/employee_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/models/company_model.dart';
import '../../../shared/models/trip_model.dart';
import '../../../shared/models/user_request_model.dart';
import '../../../shared/providers/auth/auth_provider.dart';
import '../../../shared/utils/app_color_utils.dart';
import '../../../shared/utils/app_strings_utils.dart';
import '../../../shared/utils/date_format_utils.dart';
import '../journeys/journey_details_view.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final pageIndexNotifier = ValueNotifier(0);

    var firebaseUSer = FirebaseAuth.instance.currentUser;
    final streamUser = ref.watch(StreamCurrentUserProvider(firebaseUSer!.uid));

    Future<void> logoutDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // Return an AlertDialog widget
          return AlertDialog(
            icon: const Icon(
              Icons.warning,
              color: Colors.red,
              size: 70,
            ),
            title: const Text('Do you want logout?'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('OK'),
                onPressed: () {
                  // Log user out
                  authNotifier.logout();
                },
              ),
            ],
          );
        },
      );
    }

    WoltModalSheetPage profileDialogPage(
      BuildContext modalSheetContext,
      TextTheme textTheme,
      UserModel? user,
      Company? company,
    ) {
      return WoltModalSheetPage.withSingleChild(
        hasSabGradient: false,
        topBarTitle: Text('Profile', style: textTheme.titleLarge),
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(Icons.close),
            onPressed: Navigator.of(modalSheetContext).pop,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(builder: (context, ref, child) {
            return Column(
              children: [
                Column(
                  children: [
                    TextAvatar(
                      text: company?.name.toUpperCase(),
                      shape: Shape.Circular,
                      numberLetters: 2,
                      upperCase: true,
                      fontSize: 20,
                      size: 100,
                    ),
                    ListTile(
                      title:
                          Center(child: Text("${company?.name.toUpperCase()}")),
                      // subtitle: Center(child: Text("${company?.id.toUpperCase()}")),
                      subtitle: Center(
                        child: Card(
                          color: roleCardColor(user!.role!),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Code: ${company?.id}".toUpperCase()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: TextAvatar(
                      text: '${user.firstName} ${user.lastName}'.toUpperCase(),
                      shape: Shape.Circular,
                      numberLetters: 2,
                      upperCase: true,
                    ),
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text("${user.email}"),
                  trailing: Card(
                    color: roleCardColor(user.role!),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(user.role!.toUpperCase()),
                    ),
                  ),
                ),
                const Divider(),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: logoutDialog,
                  child: const Text("Logout"),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        ),
      );
    }

    return streamUser.when(
      data: (user) => Consumer(builder: (context, ref, child) {
        final companyStream =
            ref.watch(StreamCompanyProvider(user!.companyIds.first));

        return companyStream.when(
          data: (company) {
            return Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: paddingBarWidth(context)),
                  child: const Text("Dashboard"),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: paddingBarWidth(context)),
                    child: InkWell(
                      onTap: () {
                        WoltModalSheet.show<void>(
                          pageIndexNotifier: pageIndexNotifier,
                          context: context,
                          barrierDismissible: false,
                          pageListBuilder: (modalSheetContext) {
                            final textTheme = Theme.of(context).textTheme;
                            return [
                              profileDialogPage(
                                modalSheetContext,
                                textTheme,
                                user,
                                company,
                              ),
                            ];
                          },
                          modalTypeBuilder: (context) {
                            final size = MediaQuery.of(context).size.width;
                            if (size < 400) {
                              return WoltModalType.bottomSheet;
                            } else {
                              return WoltModalType.dialog;
                            }
                          },
                          onModalDismissedWithBarrierTap: () {
                            debugPrint('Closed modal sheet with barrier tap');
                            Navigator.of(context).pop();
                            pageIndexNotifier.value = 0;
                          },
                          maxDialogWidth: 560,
                          minDialogWidth: 400,
                          minPageHeight: 0.0,
                          maxPageHeight: 0.9,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${user.firstName?.toUpperCase()}"),
                          ),
                          CircleAvatar(
                            child: TextAvatar(
                              text: '${user.firstName} ${user.lastName}'
                                  .toUpperCase(),
                              shape: Shape.Circular,
                              numberLetters: 2,
                              upperCase: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: paddingWidth(context)),
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.group),
                      title: const Text("Employees"),
                      subtitle: const Text("Manage and create employee tasks"),
                      trailing: FilledButton(
                        onPressed: () {
                          // context.go('/employees');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmployeeView(company: company!),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("View"),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.directions_bus_sharp),
                      title: const Text("Journeys"),
                      subtitle: const Text("Create trips and manage reports"),
                      trailing: FilledButton(
                        onPressed: () {
                          context.go('/journeys');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("View"),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.inbox),
                      title: const Text("Inventory"),
                      subtitle: const Text("Manage bus fleet, routes and more"),
                      trailing: FilledButton(
                        onPressed: () {
                          context.go("/inventories");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("View"),
                        ),
                      ),
                    ),
                    const Divider(),
                    Visibility(
                      visible: company?.requests.isNotEmpty ?? false,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "New Device Request",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          ListView.builder(
                            itemCount: company!.requests.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var request = company.requests[index];
                              var names = request['name'];
                              var deviceName = request['deviceName'];
                              var deviceId = request['deviceId'];
                              var phone = request['phone'];
                              var id = request['id'];
                              var companyId = request['companyId'];

                              return ListTile(
                                title: Text("$names ($phone) $id"),
                                subtitle: Text("$deviceName"),
                                trailing: TextButton(
                                  onPressed: () {
                                    databaseService
                                        .acceptEmployeeRequest(
                                            id, deviceId, deviceName)
                                        .then((value) {
                                      // clean requests
                                      databaseService.removeEmployeeRequest(
                                          companyId, request);
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Request Accepted"),
                                      ),
                                    );
                                  },
                                  child: const Text("ACCEPT"),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        // final companyData =
                        //     ref.watch(StreamCompanyProvider(user!.companyIds.first));

                        final currentTripsStream = ref.watch(
                            StreamMovingTripsProvider(user.companyIds.first));

                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Current Trips",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            currentTripsStream.when(
                              data: (trips) {
                                return trips.isNotEmpty
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            const Divider(height: 0),
                                        itemCount: trips.length,
                                        itemBuilder: (context, index) {
                                          Trip trip = trips[index];
                                          return Card(
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(10.0),
                                              title: Text(
                                                "${trip.startDest.toUpperCase()} - ${trip.endDest.toUpperCase()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "ID ${trip.id.toUpperCase()}",
                                                  ),
                                                  Text(
                                                    travelDateFormat(
                                                        trip.travelDate),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    journeyStatusText(
                                                      trip.isStarted,
                                                      trip.departure == null,
                                                    ),
                                                    style: TextStyle(
                                                      color:
                                                          journeyStatusColors(
                                                        trip.isStarted,
                                                        trip.departure == null,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.circle,
                                                      size: 20,
                                                      color:
                                                          journeyStatusColors(
                                                        trip.isStarted,
                                                        trip.departure == null,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                // context.go("/journey_details/${trip.id}",
                                                //     extra: trips);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        JourneyDetailsView(
                                                            trip: trip),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 300,
                                          width: 500,
                                          color: Colors.grey.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: FilledButton(
                                                    style:
                                                        FilledButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.green),
                                                    onPressed: () {
                                                      context.go('/journeys');
                                                    },
                                                    child: const Text(
                                                        "Open Journeys"),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    "No current trips. Please add create a new Trip from Journeys",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              },
                              error: (error, stack) {
                                debugPrint("$error");
                                return Center(child: Text("$error"));
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stack) {
            debugPrint("$error");
            return Center(child: Text("$error"));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
      error: (error, stack) {
        debugPrint("$error");
        return Scaffold(
          body: Center(child: Text("$error")),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

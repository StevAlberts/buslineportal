import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:buslineportal/ui/views/inventory/inventories_view.dart';
import 'package:buslineportal/ui/views/jobs/jobs_view.dart';
import 'package:buslineportal/ui/views/profile/create_profile_view.dart';
import 'package:buslineportal/ui/views/profile/profile_view.dart';
import 'package:buslineportal/ui/views/settings/settings_view.dart';
import 'package:buslineportal/ui/views/trips/trip_reports_view.dart';
import 'package:buslineportal/ui/views/trips/trips_view.dart';
import 'package:buslineportal/ui/widgets/error_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scaffold_responsive/scaffold_responsive.dart';

import '../../shared/providers/company/company_provider.dart';
import '../../shared/providers/users/user_provider.dart';
import 'employees/employee_view.dart';
import 'journeys/journey_view.dart';

class AppView extends ConsumerStatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  ConsumerState<AppView> createState() => _AppViewState();
}

class _AppViewState extends ConsumerState<AppView> {
  final menuController = ResponsiveMenuController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    menuController.closeIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    var firebaseUSer = FirebaseAuth.instance.currentUser;
    final streamUser = ref.watch(StreamCurrentUserProvider(firebaseUSer!.uid));

    return streamUser.when(
      data: (user) {
        return Consumer(builder: (context, ref, child) {
          final companyStream =
              ref.watch(StreamCompanyProvider(user!.companyId));

          return companyStream.when(
            data: (snapshot) {
              return ResponsiveScaffold(
                menuController: menuController,
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: menuController.toggle,
                  ),
                  title: const Text("Busline Portal"),
                  centerTitle: false,
                ),
                body: Center(
                  child: [
                    const DashboardView(),
                    JourneyView(snapshot!),
                    EmployeeView(company: snapshot),
                    const InventoriesView(),
                    const JobsView(),
                    ProfileView(
                      company: snapshot,
                      user: user,
                    ),
                    // const SettingsView(),
                    // CreateProfileView(),
                  ].elementAt(_selectedIndex),
                ),
                menu: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  child: TextAvatar(
                                    text: '${user.firstName} ${user.lastName}'
                                        .toUpperCase(),
                                    shape: Shape.Circular,
                                    numberLetters: 2,
                                    upperCase: true,
                                    size: 70,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Dashboard'),
                        leading: const Icon(Icons.dashboard),
                        selected: _selectedIndex == 0,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(0);
                        },
                      ),
                      ListTile(
                        title: const Text('Trips'),
                        leading: const Icon(Icons.location_on),
                        selected: _selectedIndex == 1,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(1);
                        },
                      ),
                      ListTile(
                        title: const Text('Staff'),
                        leading: const Icon(Icons.people_alt_outlined),
                        selected: _selectedIndex == 2,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(2);
                        },
                      ),
                      ListTile(
                        title: const Text("Inventories"),
                        leading: const Icon(Icons.directions_bus),
                        selected: _selectedIndex == 3,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(3);
                        },
                      ),
                      // ExpansionTile(
                      //   title: const Text("Inventory"),
                      //   leading: const Icon(Icons.directions_bus),
                      //   childrenPadding: const EdgeInsets.only(left: 10.0),
                      //   children: [
                      //     ListTile(
                      //       title: const Text('Routes'),
                      //       leading: const SizedBox(),
                      //       selected: _selectedIndex == 3,
                      //       onTap: () {
                      //         // Update the state of the app
                      //         _onItemTapped(3);
                      //       },
                      //     ),
                      //     ListTile(
                      //       title: const Text('Fleet'),
                      //       leading: const SizedBox(),
                      //       selected: _selectedIndex == 4,
                      //       onTap: () {
                      //         // Update the state of the app
                      //         _onItemTapped(4);
                      //       },
                      //     ),
                      //   ],
                      // ),
                      ListTile(
                        title: const Text('Account'),
                        leading: const Icon(Icons.account_circle_rounded),
                        selected: _selectedIndex == 5,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(5);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stack) {
              return ErrorView(error: error);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        });
      },
      error: (error, stack) {
        return ErrorView(error: error);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

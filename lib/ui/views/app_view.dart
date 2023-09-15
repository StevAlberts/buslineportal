import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:buslineportal/ui/views/jobs/jobs_view.dart';
import 'package:buslineportal/ui/views/settings/settings_view.dart';
import 'package:buslineportal/ui/views/trips/trip_reports_view.dart';
import 'package:buslineportal/ui/views/trips/trips_view.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_responsive/scaffold_responsive.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final menuController = ResponsiveMenuController();
  int _selectedIndex = 0;

  static const List<Widget> _pageOptions = <Widget>[
    DashboardView(),
    TripsView(),
    TripReportsView(),
    JobsView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    menuController.closeIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      menuController: menuController,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: menuController.toggle,
        ),
        title: const Text("Busline Portal"),
        centerTitle: true,
      ),
      body: Center(
        child: _pageOptions[_selectedIndex],
      ),
      menu: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
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
            ExpansionTile(
              title: const Text("Journeys"),
              leading: const Icon(Icons.directions_bus),
              childrenPadding: const EdgeInsets.only(left: 10.0),
              children: [
                ListTile(
                  title: const Text('Trips'),
                  leading: const SizedBox(),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  title: const Text('Report'),
                  leading: const SizedBox(),
                  selected: _selectedIndex == 2,
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(2);
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text('Jobs'),
              leading: const Icon(Icons.work),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashboardView(),
    );
  }
}

import 'package:buslineportal/shared/models/user_model.dart';
import 'package:buslineportal/shared/providers/users/user_provider.dart';
import 'package:buslineportal/shared/utils/dynamic_padding.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/providers/auth/auth_provider.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firebaseUSer = FirebaseAuth.instance.currentUser;
    final authNotifier = ref.read(authProvider.notifier);
    final pageIndexNotifier = ValueNotifier(0);
    final streamUser = ref.watch(streamUserRequestProvider(firebaseUSer!.uid));

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
      UserRequestModel? user,
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
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: TextAvatar(
                    text: '${user?.firstName} ${user?.lastName}'.toUpperCase(),
                    shape: Shape.Circular,
                    numberLetters: 2,
                    upperCase: true,
                  ),
                ),
                title: Text("${user?.firstName} ${user?.lastName}"),
                subtitle: Text("${user?.email}"),
                trailing: const Text("ROLE"),
              ),
              const Divider(),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: logoutDialog,
                child: const Text("Logout"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    return streamUser.when(
      data: (user) => Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  WoltModalSheet.show<void>(
                    pageIndexNotifier: pageIndexNotifier,
                    context: context,
                    barrierDismissible: false,
                    pageListBuilder: (modalSheetContext) {
                      final textTheme = Theme.of(context).textTheme;
                      return [
                        profileDialogPage(modalSheetContext, textTheme, user),
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
                      child: Text("${user?.firstName!.toUpperCase()}"),
                    ),
                    CircleAvatar(
                      child: TextAvatar(
                        text: '${user?.firstName} ${user?.lastName}'
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
          padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              ListTile(
                leading: const Icon(Icons.group),
                title: const Text("Employees"),
                subtitle: const Text("Manage and create employee tasks"),
                trailing: FilledButton(
                  onPressed: () {
                    context.go('/employees');
                  },
                  child: const Text("View"),
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
                  child: const Text("View"),
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
                  child: const Text("View"),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Current trips",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  title: const Text("Trip name"),
                  subtitle: const Text("destination"),
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${(index + 1) * 21}"),
                      ),
                      const Icon(Icons.event_seat),
                    ],
                  ),
                  onTap: () {
                    context.go("/journey_details");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) {
        debugPrint("$stack");
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

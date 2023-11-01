import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class JourneyView extends StatefulWidget {
  const JourneyView({Key? key}) : super(key: key);

  @override
  State<JourneyView> createState() => _JourneyViewState();
}

class _JourneyViewState extends State<JourneyView> {
  final pageIndexNotifier = ValueNotifier(0);
  final _formKey = GlobalKey<FormBuilderState>();

  final _emailController = TextEditingController(text: "yourEmail");

  final _companyNameController = TextEditingController();

  final _companyAddressController = TextEditingController();

  final _companyPhoneController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  final TextEditingController iconController = TextEditingController();

  String selectedRoute = 'Kampala';

  final routes = ["Kampala, Lira, Gulu, Soroti"];

  WoltModalSheetPage newTripPage(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Trip', style: textTheme.titleLarge),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderDateTimePicker(
                name: 'Travel Date',
                decoration: const InputDecoration(
                  labelText: 'Travel Date',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderDropdown<String>(
                      name: 'gender',
                      decoration: const InputDecoration(
                        labelText: 'Start Destination',
                      ),
                      items: ['Kampala', 'Lira', 'Soroti', 'Mbarara']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderDropdown<String>(
                      name: 'gender',
                      decoration: const InputDecoration(
                        labelText: 'End Destination',
                      ),
                      items: ['Kampala', 'Lira', 'Soroti', 'Mbarara']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderDropdown<String>(
                name: 'Bus',
                decoration: const InputDecoration(
                  labelText: 'Select Bus',
                ),
                items: ['UAB 123X (32")', 'UBC 456J (68")', 'UBN 111T (54")']
                    .map(
                      (bus) => DropdownMenuItem(
                        value: bus,
                        child: Text(bus),
                      ),
                    )
                    .toList(),
              ),
            ),
            ListTile(
              title: const Text("Operations Staff"),
              subtitle: const Text("Tap + button to add staff"),
              trailing: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    pageIndexNotifier.value = 1;
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (context, index) => const ListTile(
                leading: CircleAvatar(),
                title: Text("Employee name"),
                subtitle: Text("07XXXXXXXX"),
                trailing: Text("ROLE"),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("SUBMIT"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  WoltModalSheetPage employeesPage(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Select staff', style: textTheme.titleLarge),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => pageIndexNotifier.value = 0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: 12,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(),
                  title: const Text("Employee name"),
                  subtitle: const Text("07XXXXXXXX"),
                  trailing: const Text("ROLE"),
                  onTap: () => pageIndexNotifier.value = 0),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journey"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          WoltModalSheet.show<void>(
            pageIndexNotifier: pageIndexNotifier,
            context: context,
            barrierDismissible: false,
            pageListBuilder: (modalSheetContext) {
              final textTheme = Theme.of(context).textTheme;
              return [
                newTripPage(modalSheetContext, textTheme),
                employeesPage(modalSheetContext, textTheme),
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
        icon: const Icon(Icons.add),
        label: const Text("New Trip"),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Journey history"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: const Text("Trip name"),
              subtitle: const Text("destination"),
              trailing: Text("${(index + 1) * 21}"),
              onTap: () {
                context.go("/journey_details");
              },
            ),
          ),
        ],
      ),
    );
  }
}

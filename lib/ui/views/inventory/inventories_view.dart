import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class InventoriesView extends StatefulWidget {
  const InventoriesView({Key? key}) : super(key: key);

  @override
  State<InventoriesView> createState() => _InventoriesViewState();
}

class _InventoriesViewState extends State<InventoriesView> {
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

  WoltModalSheetPage newRoutePage(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Route', style: textTheme.titleLarge),
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
            const ListTile(
              title: Text("Enter name of destination city you operate"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'destination name',
                decoration: const InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: 'Destination Name',
                    hintText: "Enter destination name. eg: City A"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
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

  WoltModalSheetPage newBusPage(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Bus', style: textTheme.titleLarge),
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
            const ListTile(
              title: Text("Enter details of the new vehicle"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Licence',
                decoration: const InputDecoration(
                    icon: Icon(Icons.numbers),
                    labelText: 'Licence',
                    hintText: "Enter vehicle licence"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Make',
                decoration: const InputDecoration(
                    icon: Icon(Icons.build_circle_sharp),
                    labelText: 'Make',
                    hintText: "Enter make of the vehicle"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Model',
                decoration: const InputDecoration(
                    icon: Icon(Icons.directions_bus),
                    labelText: 'Model',
                    hintText: "Enter model of the vehicle"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Year',
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    labelText: 'Year',
                    hintText: "Enter year of the vehicle"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Capacity',
                decoration: const InputDecoration(
                    icon: Icon(Icons.event_seat),
                    labelText: 'Capacity',
                    hintText: "Enter seat capacity"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
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
    );  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventories"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Destinations"),
            subtitle: const Text("Create and manage destination routes"),
            trailing: FilledButton(
              onPressed: () {
                WoltModalSheet.show<void>(
                  pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  barrierDismissible: false,
                  pageListBuilder: (modalSheetContext) {
                    final textTheme = Theme.of(context).textTheme;
                    return [
                      newRoutePage(modalSheetContext, textTheme),
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

              child: const Text("New Route"),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
            itemBuilder: (context, index) => ListTile(
              title: const Text("Destination name"),
              onTap: () {},
            ),

          ),
          const Divider(),
          ListTile(
            title: const Text("Bus Fleet"),
            subtitle: const Text("Create and manage bus fleet"),
            trailing: FilledButton(
              onPressed: () {WoltModalSheet.show<void>(
                pageIndexNotifier: pageIndexNotifier,
                context: context,
                barrierDismissible: false,
                pageListBuilder: (modalSheetContext) {
                  final textTheme = Theme.of(context).textTheme;
                  return [
                    newBusPage(modalSheetContext, textTheme),
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

              child: const Text("New Bus"),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(),
              title: const Text("Model name"),
              subtitle: Text("200$index"),
              trailing: Text("${(index + 1) * 21} seats"),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

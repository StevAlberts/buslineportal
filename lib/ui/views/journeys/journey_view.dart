import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class JourneyView extends StatefulWidget {
  const JourneyView({Key? key}) : super(key: key);

  @override
  State<JourneyView> createState() => _JourneyViewState();
}

class _JourneyViewState extends State<JourneyView> {
  final pageIndexNotifier = ValueNotifier(0);

  final _emailController = TextEditingController(text: "yourEmail");

  final _companyNameController = TextEditingController();

  final _companyAddressController = TextEditingController();

  final _companyPhoneController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  final TextEditingController iconController = TextEditingController();

  String selectedRoute = 'Kampala';

  final routes = ["Kampala, Lira, Gulu, Soroti"];

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Trip', style: textTheme.titleLarge),
      isTopBarLayerAlwaysVisible: true,
      trailingNavBarWidget: IconButton(
        padding: const EdgeInsets.all(8.0),
        icon: const Icon(Icons.close),
        onPressed: Navigator.of(modalSheetContext).pop,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<String>(
                    label: const Text('Select start'),
                    enableFilter: true,
                    dropdownMenuEntries: <String>['Kampala', 'Lira', 'Gulu']
                        .map<DropdownMenuEntry<String>>((String item) {
                      return DropdownMenuEntry(
                        value: selectedRoute,
                        label: item,
                      );
                    }).toList(),
                    onSelected: (selected) {
                      print(selected);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<String>(
                    label: const Text('Select destination'),
                    enableFilter: true,
                    dropdownMenuEntries: <String>['Kampala', 'Lira', 'Gulu']
                        .map<DropdownMenuEntry<String>>((String item) {
                      return DropdownMenuEntry(
                        value: selectedRoute,
                        label: item,
                      );
                    }).toList(),
                    onSelected: (selected) {
                      print(selected);
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                  hintText: "Enter name of your company",
                  labelText: 'Start Destination',
                  icon: Icon(Icons.location_on)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a start destination.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _companyAddressController,
              decoration: const InputDecoration(
                  hintText:
                      "Enter locations of your offices e.g: City A, City B",
                  labelText: 'Company Address',
                  icon: Icon(Icons.location_on)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company address.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _companyPhoneController,
              decoration: const InputDecoration(
                label: Text("Company Phone Number"),
                hintText: "07XXXXXXXX",
                icon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number.';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              // controller: _companyEmailController,
              decoration: const InputDecoration(
                  hintText: "exmaple@email.com",
                  labelText: 'Company Email Address',
                  icon: Icon(Icons.alternate_email)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company email address.';
                }
                return null;
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  WoltModalSheetPage page2(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withCustomSliverList(
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(modalSheetContext).pop();
            pageIndexNotifier.value = 0;
          },
          child: Text('Close'),
        ),
      ),
      pageTitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Material Colors',
          style:
              textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      heroImage: CircleAvatar(),
      leadingNavBarWidget: IconButton(
        padding: const EdgeInsets.all(8.0),
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => pageIndexNotifier.value = pageIndexNotifier.value - 1,
      ),
      trailingNavBarWidget: IconButton(
        padding: const EdgeInsets.all(8.0),
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          pageIndexNotifier.value = 0;
        },
      ),
      sliverList: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Text("$index"),
          childCount: 5,
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
                page1(modalSheetContext, textTheme),
                page2(modalSheetContext, textTheme),
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

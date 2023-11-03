import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/providers/company/company_provider.dart';
import 'package:buslineportal/shared/providers/trips/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/models/fleet_model.dart';

class InventoriesView extends ConsumerStatefulWidget {
  const InventoriesView({Key? key}) : super(key: key);

  @override
  ConsumerState<InventoriesView> createState() => _InventoriesViewState();
}

class _InventoriesViewState extends ConsumerState<InventoriesView> {
  final pageIndexNotifier = ValueNotifier(0);

  final destNotifier = ValueNotifier("");

  final licenceNotifier = ValueNotifier("");
  final makeNotifier = ValueNotifier("");
  final modelNotifier = ValueNotifier("");
  final yearNotifier = ValueNotifier("");
  final capacityNotifier = ValueNotifier("");

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
    BuildContext modalSheetContext,
    TextTheme textTheme,
    String? destination,
  ) {
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
                name: 'destination',
                enabled: destination == null,
                initialValue: destination ?? "",
                autovalidateMode: AutovalidateMode.always,
                onChanged: (value) => destNotifier.value = value!,
                decoration: const InputDecoration(
                  labelText: 'Destination Name',
                  icon: Icon(Icons.location_on),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Visibility(
              visible: destination != null,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  databaseService.deleteRoute(destination!, "505548");
                  Navigator.pop(modalSheetContext);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("DELETE"),
                ),
              ),
            ),
            Visibility(
              visible: destination == null,
              child: FilledButton(
                onPressed: () {
                  var newDest = destination ?? destNotifier.value;
                  print("New dest: $newDest");

                  if (newDest.isNotEmpty) {
                    databaseService.createRoute(newDest, '505548');
                    // clean
                    destNotifier.value = "";
                    // pop sheet
                    Navigator.pop(modalSheetContext);
                  } else {
                    // show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: ListTile(
                          leading: Icon(Icons.error_outline, color: Colors.red),
                          title: Text(
                            "Please complete the form.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("SUBMIT"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  WoltModalSheetPage newBusPage(
    BuildContext modalSheetContext,
    TextTheme textTheme,
    Fleet? fleet,
  ) {
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
                name: 'licence',
                enabled: fleet == null,
                initialValue: fleet?.licence ?? "",
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => licenceNotifier.value = value!,
                decoration: const InputDecoration(
                    icon: Icon(Icons.numbers),
                    labelText: 'Licence',
                    hintText: "Enter vehicle licence"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Make',
                enabled: fleet == null,
                initialValue: fleet?.make ?? "",
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => makeNotifier.value = value!,
                decoration: const InputDecoration(
                    icon: Icon(Icons.travel_explore),
                    labelText: 'Make',
                    hintText: "Enter make of the vehicle"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Model',
                enabled: fleet == null,
                initialValue: fleet?.model ?? "",
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => modelNotifier.value = value!,
                decoration: const InputDecoration(
                    icon: Icon(Icons.directions_bus),
                    labelText: 'Model',
                    hintText: "Enter model of the vehicle"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Year',
                enabled: fleet == null,
                initialValue: fleet?.year.toString() ?? "",
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => yearNotifier.value = value!,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    labelText: 'Year',
                    hintText: "Enter year of the vehicle"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Capacity',
                enabled: fleet == null,
                initialValue: fleet?.capacity.toString() ?? "",
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => capacityNotifier.value = value!,
                decoration: const InputDecoration(
                  icon: Icon(Icons.event_seat),
                  labelText: 'Capacity',
                  hintText: "Enter seat capacity",
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Visibility(
              visible: fleet != null,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  databaseService.deleteFleet(fleet!, "505548");
                  Navigator.pop(modalSheetContext);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("DELETE"),
                ),
              ),
            ),
            Visibility(
              visible: fleet == null,
              child: FilledButton(
                onPressed: () {
                  var licence = fleet?.licence ?? licenceNotifier.value;
                  var make = fleet?.make ?? makeNotifier.value;
                  var model = fleet?.model ?? modelNotifier.value;
                  var year = fleet?.year.toString() ?? yearNotifier.value;
                  var capacity =
                      fleet?.capacity.toString() ?? capacityNotifier.value;

                  if (licence.isNotEmpty &&
                      make.isNotEmpty &&
                      model.isNotEmpty &&
                      year.isNotEmpty &&
                      licence.isNotEmpty &&
                      capacity.isNotEmpty) {
                    // create fleet
                    var fleet0 = Fleet(
                      id: licence.toLowerCase(),
                      companyId: '',
                      licence: licence,
                      make: make,
                      model: model,
                      year: int.parse(year),
                      capacity: int.parse(capacity),
                    );
                    // add
                    databaseService.createFleet(fleet0, '505548');
                    // clean
                    destNotifier.value = "";
                    // pop sheet
                    Navigator.pop(modalSheetContext);
                  } else {
                    // show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: ListTile(
                          leading: Icon(Icons.error_outline, color: Colors.red),
                          title: Text(
                            "Please complete the form.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("SUBMIT"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRouteDialog({String? destination}) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          newRoutePage(modalSheetContext, textTheme, destination),
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
  }

  void showFleetDialog(Fleet? fleet) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          newBusPage(modalSheetContext, textTheme, fleet),
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
  }

  @override
  Widget build(BuildContext context) {
    final companyStream = ref.watch(StreamCompanyProvider("505548"));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventories"),
      ),
      body: companyStream.when(
        data: (company) {
          return ListView(
            children: [
              ListTile(
                title: const Text("Destinations"),
                subtitle: const Text("Create and manage destination routes"),
                trailing: FilledButton(
                  onPressed: () => showRouteDialog(),
                  child: const Text("New Route"),
                ),
              ),
              company!.destinations.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: company.destinations.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (context, index) => ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.location_on),
                        ),
                        title: Text(
                          company.destinations[index].toString().toUpperCase(),
                        ),
                        onTap: () => showRouteDialog(
                            destination: company.destinations[index]),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No Destinations. Please add a New Route"),
                      ),
                    ),
              const Divider(),
              ListTile(
                title: const Text("Bus Fleet"),
                subtitle: const Text("Create and manage bus fleet"),
                trailing: FilledButton(
                  onPressed: () => showFleetDialog(null),
                  child: const Text("New Bus"),
                ),
              ),
              company.fleet.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: company.fleet.length,
                      itemBuilder: (context, index) {
                        var bus = company.fleet[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.directions_bus_sharp),
                          ),
                          title: Text(bus.licence.toUpperCase()),
                          subtitle: Text(
                              "${bus.model} (${bus.capacity}) Seater / ${bus.make}"),
                          trailing: Text(" ${bus.year}"),
                          onTap: () => showFleetDialog(bus),
                        );
                      },
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No Buses. Please add a New Bus"),
                      ),
                    ),
            ],
          );
        },
        error: (error, strace) {
          print(strace);
          print(error);
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

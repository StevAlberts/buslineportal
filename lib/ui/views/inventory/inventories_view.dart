import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/providers/company/company_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/models/fleet_model.dart';
import '../../../shared/providers/users/user_provider.dart';
import '../../../shared/utils/dynamic_padding.dart';

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
    String companyId,
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
                  databaseService.deleteRoute(destination!, companyId);
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
                    databaseService
                        .createRoute(newDest, companyId)
                        .onError((error, stackTrace) {
                      print("New error: $error");
                    });
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
      String companyId
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
                  databaseService.deleteFleet(fleet!, companyId);
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
                    databaseService.createFleet(fleet0, companyId);
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

  void showRouteDialog(companyId, {String? destination}) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          newRoutePage(modalSheetContext, textTheme, destination, companyId),
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

  void showFleetDialog(Fleet? fleet,String companyId) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          newBusPage(modalSheetContext, textTheme, fleet,companyId),
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
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final currentUserStream =
        ref.read(StreamCurrentUserProvider(firebaseUser!.uid));

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingBarWidth(context)),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.pushReplacement('/');
                },
                child: const Text(
                  "Dashboard",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Text(" / Inventories"),
            ],
          ),
        ),
      ),
      body: currentUserStream.when(
        data: (user) {
          return Consumer(builder: (context, ref, child) {
            final companyStream =
                ref.watch(StreamCompanyProvider(user!.companyIds.first));

            return companyStream.when(
              data: (company) {
                return ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: paddingWidth(context)),
                  children: [
                    ListTile(
                      title: const Text("Bus Routes"),
                      subtitle:
                          const Text("Create and manage destination bus routes"),
                      trailing: FilledButton(
                        onPressed: () => showRouteDialog(company?.id),
                        child: const Text("New Route"),
                      ),
                    ),
                    company!.destinations.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: company.destinations.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (context, index) => ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.location_on),
                              ),
                              title: Text(
                                company.destinations[index]
                                    .toString()
                                    .toUpperCase(),
                              ),
                              onTap: () => showRouteDialog(company.id,
                                  destination: company.destinations[index]),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        onPressed: () =>
                                            showRouteDialog(company.id),
                                        child: const Text("Add Route"),
                                      ),
                                    ),
                                    const Text(
                                      "No Destinations. Please add a New Route",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const Divider(),
                    ListTile(
                      title: const Text("Bus Fleet"),
                      subtitle: const Text("Create and manage bus fleet"),
                      trailing: FilledButton(
                        onPressed: () => showFleetDialog(null,company.id),
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
                                onTap: () => showFleetDialog(bus,company.id),
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        onPressed: () => showFleetDialog(null,company.id),
                                        child: const Text("Add Bus"),
                                      ),
                                    ),
                                    const Text(
                                      "No Buses. Please add a New Bus",
                                    ),
                                  ],
                                ),
                              ),
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
            );
          });
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

import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/shared/models/employee_model.dart';
import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:buslineportal/shared/models/trip_model.dart';
import 'package:buslineportal/shared/providers/trips/trips_provider.dart';
import 'package:buslineportal/shared/utils/app_strings_utils.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:buslineportal/ui/views/journeys/journey_details_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:otp/otp.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../network/services/database_services.dart';
import '../../../shared/models/fleet_model.dart';
import '../../../shared/providers/company/company_provider.dart';
import '../../../shared/providers/staff/employees_provider.dart';
import '../../../shared/providers/users/user_provider.dart';
import '../../../shared/utils/dynamic_padding.dart';
import '../../../shared/utils/app_color_utils.dart';
import '../employees/employee_view.dart';

final selectedEmployeesProvider = StateProvider((ref) => <Employee>{});

class JourneyView extends ConsumerStatefulWidget {
  const JourneyView({Key? key}) : super(key: key);

  @override
  ConsumerState<JourneyView> createState() => _JourneyViewState();
}

class _JourneyViewState extends ConsumerState<JourneyView> {
  final pageIndexNotifier = ValueNotifier(0);

  final _emailController = TextEditingController(text: "yourEmail");

  final _companyNameController = TextEditingController();

  final _companyAddressController = TextEditingController();

  final _companyPhoneController = TextEditingController();

  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  String selectedRoute = 'Kampala';
  final routes = ["Kampala, Lira, Gulu, Soroti"];

  // final pageIndexNotifier = ValueNotifier(0);
  final pageCreateIndexNotifier = ValueNotifier(0);
  // final _formKey = GlobalKey<FormBuilderState>();

  final statusNotifier = ValueNotifier(false);
  final travelNotifier = ValueNotifier("");
  final startDestNotifier = ValueNotifier("");
  final endDestNotifier = ValueNotifier("");
  final busNotifier = ValueNotifier("");
  final priceNotifier = ValueNotifier("");

  WoltModalSheetPage editTripPage(
    BuildContext modalSheetContext,
    TextTheme textTheme, {
    Trip? trip,
    required String compId,
    required List<Fleet> buses,
    required List destinations,
  }) {
    // final employeesStream = ref.watch(StreamCompanyEmployeesProvider());
    final selectedStaff = ref.read(selectedEmployeesProvider);
    final employeesStream = ref.watch(StreamCompanyEmployeesProvider(compId));
    // final companyStream = ref.read(StreamCompanyProvider()).value;
    // final tripsStream = ref.watch(StreamAllTripsProvider());

    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Trip Schedule', style: textTheme.titleLarge),
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
        child: FormBuilder(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderSwitch(
                  name: 'status',
                  enabled: trip != null,
                  initialValue: trip?.isStarted ?? false,
                  decoration: const InputDecoration(
                    labelText: 'Journey Status',
                    hintText: "Change journey status",
                  ),
                  title: const Text("STARTED"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => statusNotifier.value = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDateTimePicker(
                  name: 'travel',
                  initialValue: trip?.travelDate,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'Travel Date',
                    hintText: "Select travel date",
                    icon: Icon(Icons.calendar_month),
                  ),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  firstDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) =>
                      travelNotifier.value = value?.toIso8601String() ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'startDest',
                  initialValue: trip?.startDest ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'Start Destination',
                    hintText: "Select Destination",
                    icon: Icon(Icons.location_on),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(1),
                    FormBuilderValidators.required(
                        errorText: "Please + add NEW ROUTES from Inventories*"),
                  ]),
                  onChanged: (value) => startDestNotifier.value = value!,
                  items: destinations
                      .map(
                        (dest) => DropdownMenuItem(
                          value: dest.toString(),
                          child: Text(dest.toString().toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'endDest',
                  initialValue: trip?.endDest ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'End Destination',
                    hintText: "Select Destination",
                    icon: Icon(Icons.location_off),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(1),
                    FormBuilderValidators.required(
                        errorText: "Please + add NEW ROUTES from Inventories*"),
                  ]),
                  onChanged: (value) => endDestNotifier.value = value!,
                  items: destinations
                      .map(
                        (dest) => DropdownMenuItem(
                          value: dest.toString(),
                          child: Text(dest.toString().toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'bus',
                  initialValue: trip?.bus.licence ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'Select Bus',
                    hintText: 'Select Bus',
                    icon: Icon(Icons.directions_bus_sharp),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => busNotifier.value = value!,
                  items: buses
                      .map(
                        (fleet) => DropdownMenuItem(
                          value: fleet.licence,
                          child: Text(fleet.licence.toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'fare',
                  initialValue: trip?.fare.toString() ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'Ticket Price',
                    hintText: 'Enter price of ticket',
                    icon: Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => priceNotifier.value = value!,
                ),
              ),
              ExpansionTile(
                title: const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.group),
                  title: Text("Add Staff"),
                ),
                children: [
                  employeesStream.when(
                    data: (employees) {
                      return employees.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: employees.length,
                              itemBuilder: (context, index) =>
                                  FormBuilderSwitch(
                                contentPadding: EdgeInsets.zero,
                                name: employees[index].id,
                                initialValue:
                                    selectedStaff.contains(employees[index]),
                                title: ListTile(
                                  leading: CircleAvatar(
                                    child: TextAvatar(
                                      text:
                                          '${employees[index].firstName} ${employees[index].lastName}'
                                              .toUpperCase(),
                                      shape: Shape.Circular,
                                      numberLetters: 2,
                                      upperCase: true,
                                    ),
                                  ),
                                  title: Text(
                                      "${employees[index].firstName} ${employees[index].lastName}"),
                                  subtitle: Text(
                                    employees[index].role.toUpperCase(),
                                    style: TextStyle(
                                      color:
                                          roleTextColor(employees[index].role),
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                onChanged: (value) {
                                  if (value != null && value) {
                                    StateController<Set<Employee>> selectedVal =
                                        ref.read(
                                            selectedEmployeesProvider.notifier);
                                    selectedVal.state.add(employees[index]);
                                  } else {
                                    StateController<Set<Employee>> selectedVal =
                                        ref.read(
                                            selectedEmployeesProvider.notifier);
                                    selectedVal.state.remove(employees[index]);
                                  }
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FilledButton(
                                            style: FilledButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () =>
                                                context.go("/employees"),
                                            child: const Text("Open Employees"),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "No employees. Please go to Employees and add Staff",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                    error: (error, stack) {
                      debugPrint("$stack");
                      return Center(child: Text("$error"));
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  onPressed: () {
                    var uuid = const Uuid().v4();

                    var uuidString = uuid.toString();
                    var tripId = uuidString.substring(0, 6);

                    var status = trip?.isStarted ?? statusNotifier.value;
                    var travelDate = trip?.travelDate.toIso8601String() ??
                        travelNotifier.value;
                    var startDest = trip?.startDest ?? startDestNotifier.value;
                    var endDest = trip?.endDest ?? endDestNotifier.value;
                    var price = trip?.fare.toString() ?? priceNotifier.value;

                    var licence = trip?.bus.licence ?? busNotifier.value;

                    // var busSeats =
                    //     trip?.busSeats.toString() ?? busNotifier.value;

                    var staffDetails = trip?.staffDetails ??
                        selectedStaff
                            .map((employee) =>
                                StaffDetail.fromJson(employee.toJson()))
                            .toList();

                    if (travelDate.isNotEmpty &&
                        startDest.isNotEmpty &&
                        endDest.isNotEmpty &&
                        licence.isNotEmpty &&
                        price.isNotEmpty &&
                        staffDetails.isNotEmpty) {
                      var bus = buses
                          .firstWhere((element) => element.licence == licence);

                      // create trip model
                      var trip0 = Trip(
                        id: tripId,
                        companyId: compId,
                        companyDetails: null,
                        bus: bus,
                        fare: int.parse(price),
                        staffDetails: staffDetails,
                        startDest: startDest,
                        endDest: endDest,
                        isStarted: status,
                        travelDate: DateTime.parse(travelDate),
                        passengers: [],
                        departure: null,
                        arrival: null,
                      );

                      if (trip == null) {
                        // save trip
                        databaseService.createTrip(trip0);
                      } else {
                        // update trip
                        databaseService.updateTrip(trip0);
                      }

                      // clean notifiers
                      statusNotifier.value = false;
                      travelNotifier.value = "";
                      startDestNotifier.value = "";
                      startDestNotifier.value = "";
                      busNotifier.value = "";
                      priceNotifier.value = "";
                      // pop sheet
                      Navigator.pop(modalSheetContext);
                    } else {
                      // show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: ListTile(
                            leading:
                                Icon(Icons.error_outline, color: Colors.red),
                            title: Text(
                              "Please complete the form with added staff",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }

                    // var employee0 = Employee(
                    //   id: employee!.id,
                    //   companyId: employee.companyId,
                    //   firstName: firstName,
                    //   lastName: lastName,
                    //   gender: gender,
                    //   dob: DateTime.parse(dob),
                    //   nin: nin,
                    //   phone: phone,
                    //   role: role,
                    //   isOnline: employee.isOnline,
                    //   jobs: employee.jobs,
                    // );
                    //
                    // // update employee to database
                    // databaseService.updateEmployee(employee0);
                    //
                    // // show success
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: ListTile(
                    //       leading: Icon(Icons.check, color: Colors.green),
                    //       title: Text(
                    //         "Details updated",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // );
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
      ),
    );
  }

  void showTripDialog(Company company) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          // create trip view
          editTripPage(
            modalSheetContext,
            textTheme,
            trip: null,
            buses: company.fleet,
            destinations: company.destinations.toList(),
            compId: company.id,
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
  }

  @override
  Widget build(BuildContext context) {
    final selectedStaff = ref.watch(selectedEmployeesProvider);

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
              const Text(" / Journeys"),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: currentUserStream.when(
        data: (user) {
          return Consumer(builder: (context, ref, child) {
            String compId = user?.companyIds.first;

            /// TODO: likely to give NULL
            final company =
                ref.watch(StreamCompanyProvider(compId)).valueOrNull;
            final employeesStream =
                ref.watch(StreamCompanyEmployeesProvider(compId)).valueOrNull;
            final tripsStream = ref.watch(StreamAllTripsProvider(compId));

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
              children: [
                ListTile(
                  title: const Text("Journey history"),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton.icon(
                      onPressed: () => showTripDialog(company!),
                      icon: const Icon(Icons.add),
                      label: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Schedule Trip"),
                      ),
                    ),
                  ),
                ),
                tripsStream.when(
                  data: (trips) {
                    print("Trips: ${trips.length}");
                    return trips.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const Divider(height: 0),
                            itemCount: trips.length,
                            itemBuilder: (context, index) {
                              Trip trip = trips[index];
                              return Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  title: Text(
                                    "${trip.startDest.toUpperCase()} - ${trip.endDest.toUpperCase()}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID ${trip.id.toUpperCase()}",
                                      ),
                                      Text(
                                        travelDateFormat(trip.travelDate),
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
                                          color: journeyStatusColors(
                                            trip.isStarted,
                                            trip.departure == null,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.circle,
                                          size: 20,
                                          color: journeyStatusColors(
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
                                            JourneyDetailsView(trip: trip),
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
                              height: 200,
                              width: 300,
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
                                            showTripDialog(company!),
                                        child: const Text("Schedule Trip"),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "No previous trips. Please click to add New Trip to create a Journey",
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
                ),
              ],
            );
          });
        },
        error: (error, stack) {
          debugPrint("$error");
          return Center(child: Text("$error"));
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

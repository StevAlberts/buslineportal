import 'package:buslineportal/shared/models/employee_model.dart';
import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:buslineportal/shared/models/trip_model.dart';
import 'package:buslineportal/shared/providers/trips/trips_provider.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:otp/otp.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../network/services/database_services.dart';
import '../../../shared/providers/staff/employees_provider.dart';
import '../../../shared/utils/role_color_utils.dart';
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
    TextTheme textTheme,
    Trip? trip,
  ) {
    final employeesStream = ref.watch(StreamAllEmployeesProvider("505548"));
    final selectedStaff = ref.watch(selectedEmployeesProvider);

    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Journey Details', style: textTheme.titleLarge),
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
                  initialValue: trip?.isMoving ?? false,
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
                      travelNotifier.value = value!.toIso8601String(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'startDest',
                  initialValue: trip?.firstName ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'Start Destination',
                    hintText: "Select Destination",
                    icon: Icon(Icons.location_on),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(1),
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => startDestNotifier.value = value!,
                  items: ['Kampala', 'Lira', 'Soroti', 'Mbarara']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'endDest',
                  initialValue: trip?.firstName ?? '',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    labelText: 'End Destination',
                    hintText: "Select Destination",
                    icon: Icon(Icons.location_off),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(1),
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => endDestNotifier.value = value!,
                  items: ['Kampala', 'Lira', 'Soroti', 'Mbarara']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'bus',
                  initialValue: trip?.firstName ?? '',
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
                  items: ['UAB 123X (32")', 'UBC 456J (68")', 'UBN 111T (54")']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'fare',
                  initialValue: trip?.firstName ?? '',
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
              // CheckboxListTile( title:Text("keke"),value: false, onChanged: (value){}),
              ExpansionTile(
                title: const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.group),
                  title: Text("Add Staff"),
                ),
                children: [
                  employeesStream.when(
                    data: (employees) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: employees.length,
                        itemBuilder: (context, index) => FormBuilderSwitch(
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
                                color: roleTextColor(employees[index].role),
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          onChanged: (value) {
                            print(selectedStaff);
                            if (value != null && value) {
                              StateController<Set<Employee>> selectedVal =
                                  ref.read(selectedEmployeesProvider.notifier);
                              selectedVal.state.add(employees[index]);
                            } else {
                              StateController<Set<Employee>> selectedVal =
                                  ref.read(selectedEmployeesProvider.notifier);
                              selectedVal.state.remove(employees[index]);
                            }
                            print(selectedStaff);
                            print(".....");
                          },
                        ),
                      );
                    },
                    error: (error, stack) {
                      debugPrint("$stack");
                      return Center(child: Text("$error"));
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  onPressed: () {
                    var uuid = const Uuid().v4();

                    /// TODO: get ID from UserDetails
                    var companyId = OTP.generateTOTPCodeString(
                      "JBSWY3DPEHPK3PXP",
                      1362302550000,
                    ); // -> '505548'
                    var uuidString = uuid.toString();
                    var tripId = uuidString.substring(0, 6);

                    var status = trip?.isMoving ?? statusNotifier.value;
                    var travelDate = trip?.travelDate.toIso8601String() ??
                        travelNotifier.value;
                    var startDest = trip?.lastName ?? startDestNotifier.value;
                    var endDest = trip?.gender ?? endDestNotifier.value;
                    var bus = trip?.phone ?? busNotifier.value;
                    var price = trip?.role ?? priceNotifier.value;

                    var busNo = trip?.busNo ?? busNotifier.value;
                    var busSeats =
                        trip?.busSeats.toString() ?? busNotifier.value;

                    var staffDetails = trip?.staffDetails ??
                        selectedStaff
                            .map((employee) =>
                                StaffDetail.fromJson(employee.toJson()))
                            .toList();

                    if (travelDate.isNotEmpty &&
                        startDest.isNotEmpty &&
                        endDest.isNotEmpty &&
                        bus.isNotEmpty &&
                        price.isNotEmpty &&
                        staffDetails.isNotEmpty) {
                      // create trip model
                      var trip0 = Trip(
                        id: tripId,
                        companyId: companyId,
                        companyDetails: null,
                        busNo: busNo,
                        busSeats: 0,
                        staffDetails: staffDetails,
                        startDest: startDest,
                        endDest: endDest,
                        isMoving: status,
                        travelDate: DateTime.parse(travelDate),
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

  void _showNewTripDialog() {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      barrierDismissible: false,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          // staff details view
          // staffDetailsPage(
          //   modalSheetContext,
          //   textTheme,
          //   employee,
          // ),

          // create trip view
          editTripPage(
            modalSheetContext,
            textTheme,
            null,
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
    final tripsStream = ref.watch(StreamAllTripsProvider("505548"));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Journey"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewTripDialog,
        icon: const Icon(Icons.add),
        label: const Text("New Trip"),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Journey history"),
          ),
          tripsStream.when(
            data: (trips) {
              print(trips.length);
              return trips.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trips.length,
                      itemBuilder: (context, index) => ListTile(
                        title: const Text("Trip name"),
                        subtitle: const Text("destination"),
                        trailing: Text("${(index + 1) * 21}"),
                        onTap: () {
                          context.go("/journey_details");
                        },
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          const Icon(Icons.hourglass_empty),
                          Text(
                            "No Trips",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
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
        ],
      ),
    );
  }
}

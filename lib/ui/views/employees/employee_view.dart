import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/models/employee_model.dart';
import 'package:buslineportal/shared/providers/staff/employees_provider.dart';
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

import '../../../shared/providers/users/user_provider.dart';
import '../../../shared/utils/date_format_utils.dart';
import '../../../shared/utils/dynamic_padding.dart';
import '../../../shared/utils/mask_phone_utils.dart';
import '../../../shared/utils/app_color_utils.dart';

class EmployeeView extends ConsumerStatefulWidget {
  const EmployeeView({Key? key}) : super(key: key);

  @override
  ConsumerState<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends ConsumerState<EmployeeView> {
  final pageIndexNotifier = ValueNotifier(0);
  final pageCreateIndexNotifier = ValueNotifier(0);
  final _formKey = GlobalKey<FormBuilderState>();

  final fnameNotifier = ValueNotifier("");
  final lnameNotifier = ValueNotifier("");
  final genderNotifier = ValueNotifier("");
  final dobNotifier = ValueNotifier("");
  final ninNotifier = ValueNotifier("");
  final phoneNotifier = ValueNotifier("");
  final roleNotifier = ValueNotifier("");

  WoltModalSheetPage createStaffPage(
      BuildContext modalSheetContext, TextTheme textTheme, String? companyId) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Staff Details', style: textTheme.titleLarge),
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
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'first_name',
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'last_name',
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'gender',
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    hintText: "Select gender",
                    icon: Icon(Icons.group),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: ['male', 'female']
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
                child: FormBuilderDateTimePicker(
                  name: 'dob',
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: "Select gender",
                    icon: Icon(Icons.calendar_month),
                  ),
                  initialDatePickerMode: DatePickerMode.year,
                  inputType: InputType.date,
                  initialEntryMode: DatePickerEntryMode.input,
                  initialDate: DateTime(2000),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FormBuilderTextField(
              //     name: 'nin',
              //     decoration: const InputDecoration(
              //       labelText: 'NIN',
              //       icon: Icon(Icons.branding_watermark),
              //     ),
              //     validator: FormBuilderValidators.compose([
              //       FormBuilderValidators.required(),
              //     ]),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'phone',
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    icon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(
                      errorText: 'Enter valid phone number',
                    ),
                    FormBuilderValidators.minLength(10),
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'role',
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    hintText: "Select role",
                    icon: Icon(Icons.security),
                  ),
                  items: ['conductor', 'driver', 'staff']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        ),
                      )
                      .toList(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  onPressed: () {
                    var uuid = const Uuid().v4();
                    // var companyId = OTP.generateTOTPCodeString(
                    //   "JBSWY3DPEHPK3PXP",
                    //   1362302550000,
                    // ); // -> '505548'
                    var uuidString = uuid.toString();
                    var employeeId = OTP.generateTOTPCodeString(
                      uuidString,
                      DateTime.now().millisecondsSinceEpoch,
                    );

                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      var firstName =
                          _formKey.currentState?.instantValue["first_name"];
                      var lastName =
                          _formKey.currentState?.instantValue["last_name"];
                      var gender =
                          _formKey.currentState?.instantValue["gender"];
                      var phone = _formKey.currentState?.instantValue["phone"];
                      var role = _formKey.currentState?.instantValue["role"];
                      var dob = _formKey.currentState?.instantValue["dob"];
                      // var nin = _formKey.currentState?.instantValue["nin"];

                      var employee0 = Employee(
                        id: employeeId,
                        companyId: "$companyId",
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        dob: dob,
                        // nin: nin,
                        phone: phone,
                        role: role,
                        isOnline: false,
                        jobs: [],
                      );

                      // create employee to database
                      databaseService.createEmployee(employee0);

                      // show success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: ListTile(
                            leading: Icon(Icons.check, color: Colors.green),
                            title: Text(
                              "New staff added",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );

                      // pop sheet
                      Navigator.pop(modalSheetContext);
                      pageIndexNotifier.value = 0;
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
      ),
    );
  }

  WoltModalSheetPage editStaffPage(
    BuildContext modalSheetContext,
    TextTheme textTheme,
    Employee? employee,
  ) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Edit Staff Details', style: textTheme.titleLarge),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: Visibility(
        visible: employee != null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              padding: const EdgeInsets.all(8.0),
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => pageIndexNotifier.value = 0),
        ),
      ),
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
          // key: _formUpdateKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'first_name',
                  initialValue: employee?.firstName ?? "",
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => fnameNotifier.value = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'last_name',
                  initialValue: employee?.lastName ?? "",
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => lnameNotifier.value = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'gender',
                  initialValue: employee?.gender ?? "",
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    hintText: "Select gender",
                    icon: Icon(Icons.group),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => genderNotifier.value = value!,
                  items: ['male', 'female']
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
                child: FormBuilderDateTimePicker(
                  name: 'dob',
                  initialValue: employee?.dob ?? DateTime.now(),
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: "Select gender",
                    icon: Icon(Icons.calendar_month),
                  ),
                  initialDatePickerMode: DatePickerMode.year,
                  inputType: InputType.date,
                  initialEntryMode: DatePickerEntryMode.input,
                  initialDate: DateTime(2000),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) =>
                      dobNotifier.value = value!.toIso8601String(),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FormBuilderTextField(
              //     name: 'nin',
              //     initialValue: employee?.nin,
              //     decoration: const InputDecoration(
              //       labelText: 'NIN',
              //       icon: Icon(Icons.branding_watermark),
              //     ),
              //     validator: FormBuilderValidators.compose([
              //       FormBuilderValidators.required(),
              //     ]),
              //     onChanged: (value) => ninNotifier.value = value!,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'phone',
                  initialValue: employee?.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    icon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(
                      errorText: 'Enter valid phone number',
                    ),
                    FormBuilderValidators.minLength(10),
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => phoneNotifier.value = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<String>(
                  name: 'role',
                  initialValue: employee?.role,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    hintText: "Select role",
                    icon: Icon(Icons.security),
                  ),
                  items: ['conductor', 'driver', 'staff']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        ),
                      )
                      .toList(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) => roleNotifier.value = value!,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          pageIndexNotifier.value = 2;
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("DELETE"),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        var firstName = fnameNotifier.value.isNotEmpty
                            ? fnameNotifier.value
                            : employee!.firstName;
                        var lastName = lnameNotifier.value.isNotEmpty
                            ? lnameNotifier.value
                            : employee!.lastName;
                        var gender = genderNotifier.value.isNotEmpty
                            ? genderNotifier.value
                            : employee!.gender;
                        var phone = phoneNotifier.value.isNotEmpty
                            ? phoneNotifier.value
                            : employee!.phone;
                        var role = roleNotifier.value.isNotEmpty
                            ? roleNotifier.value
                            : employee!.role;
                        var dob = dobNotifier.value.isNotEmpty
                            ? dobNotifier.value
                            : employee!.dob.toIso8601String();
                        // var nin = ninNotifier.value.isNotEmpty
                        //     ? ninNotifier.value
                        //     : employee!.nin;

                        var employee0 = Employee(
                          id: employee!.id,
                          companyId: employee.companyId,
                          firstName: firstName,
                          lastName: lastName,
                          gender: gender,
                          dob: DateTime.parse(dob),
                          // nin: nin,
                          phone: phone,
                          role: role,
                          isOnline: employee.isOnline,
                          jobs: employee.jobs,
                        );

                        // update employee to database
                        databaseService.updateEmployee(employee0);

                        // show success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: ListTile(
                              leading: Icon(Icons.check, color: Colors.green),
                              title: Text(
                                "Details updated",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );

                        // pop sheet
                        Navigator.pop(modalSheetContext);
                        pageIndexNotifier.value = 0;
                        // }
                      },
                      // style: FilledButton.styleFrom(backgroundColor: Colors.bl),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("UPDATE"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  WoltModalSheetPage confirmDeletePage(
    BuildContext modalSheetContext,
    TextTheme textTheme,
    Employee employee,
  ) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Confirm Delete', style: textTheme.titleLarge),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => pageIndexNotifier.value = 0),
      ),
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
              child: CircleAvatar(
                radius: 30,
                child: TextAvatar(
                  text: '${employee.firstName} ${employee.lastName}'
                      .toUpperCase(),
                  shape: Shape.Circular,
                  numberLetters: 2,
                  upperCase: true,
                  size: 70,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${employee.firstName} ${employee.lastName}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const ListTile(
              title: Center(
                child: Text("Are you sure about DELETE staff?"),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      // delete employee to database
                      databaseService.deleteEmployee(employee.id);

                      // show success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: ListTile(
                            leading: Icon(Icons.check, color: Colors.red),
                            title: Text(
                              "Details deleted",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );

                      // pop sheet
                      Navigator.pop(modalSheetContext);
                      // }
                    },
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("DELETE"),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      // pop sheet
                      pageIndexNotifier.value = 0;
                      Navigator.pop(modalSheetContext);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("CANCEL"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  WoltModalSheetPage staffDetailsPage(
    BuildContext modalSheetContext,
    TextTheme textTheme,
    Employee employee,
    String? compId,
  ) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('Staff Details', style: textTheme.titleLarge),
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
              child: CircleAvatar(
                radius: 50,
                child: TextAvatar(
                  text: '${employee.firstName} ${employee.lastName}'
                      .toUpperCase(),
                  shape: Shape.Circular,
                  numberLetters: 2,
                  upperCase: true,
                  size: 100,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${employee.firstName} ${employee.lastName}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "COMPANY ID $compId".toUpperCase(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("ID"),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(employee.id.toUpperCase()),
              ),
            ),
            ListTile(
              title: const Text("ROLE"),
              trailing: Card(
                color: roleCardColor(employee.role),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(employee.role.toUpperCase()),
                ),
              ),
            ),
            ListTile(
              title: const Text("CONTACT"),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(maskPhoneNumber(employee.phone.toUpperCase())),
              ),
            ),
            ListTile(
              title: const Text("DOB"),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(dobDateFormat(employee.dob)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.icon(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
                onPressed: () {
                  pageIndexNotifier.value = 1;
                },
                label: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("EDIT"),
                ),
              ),
            ),
          ],
        ),
      ),
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
              const Text(" / Employees"),
            ],
          ),
        ),
      ),
      body: currentUserStream.when(
        data: (user) {
          String compId = user!.companyIds.first;

          return Consumer(builder: (context, ref, child) {
            final employeesStream =
                ref.watch(StreamCompanyEmployeesProvider(compId));

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
              children: [
                ListTile(
                  title: const Text("Staff list"),
                  subtitle: const Text("Create and manage company staff"),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.lightBlue),
                      icon: const Icon(Icons.add),
                      label: const Text("New"),
                      onPressed: () {
                        WoltModalSheet.show<void>(
                          pageIndexNotifier: pageCreateIndexNotifier,
                          context: context,
                          barrierDismissible: false,
                          pageListBuilder: (modalSheetContext) {
                            final textTheme = Theme.of(context).textTheme;
                            return [
                              // new staff
                              createStaffPage(
                                  modalSheetContext, textTheme, compId),
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
                            pageCreateIndexNotifier.value = 0;
                          },
                          maxDialogWidth: 560,
                          minDialogWidth: 400,
                          minPageHeight: 0.0,
                          maxPageHeight: 0.9,
                        );
                      },
                    ),
                  ),
                ),
                employeesStream.when(
                  data: (employees) {
                    return employees.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: employees.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(height: 0),
                            itemBuilder: (context, index) {
                              var employee = employees[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: TextAvatar(
                                    text:
                                        '${employee.firstName} ${employee.lastName}'
                                            .toUpperCase(),
                                    shape: Shape.Circular,
                                    numberLetters: 2,
                                    upperCase: true,
                                  ),
                                ),
                                title: Text(
                                    "${employee.firstName} ${employee.lastName}"),
                                subtitle:
                                    Text("ID ${employee.id.toUpperCase()}"),
                                onTap: () {
                                  WoltModalSheet.show<void>(
                                    pageIndexNotifier: pageIndexNotifier,
                                    context: context,
                                    barrierDismissible: false,
                                    pageListBuilder: (modalSheetContext) {
                                      final textTheme =
                                          Theme.of(context).textTheme;
                                      return [
                                        // staff details view
                                        staffDetailsPage(modalSheetContext,
                                            textTheme, employee, compId),

                                        // page edit view
                                        editStaffPage(
                                          modalSheetContext,
                                          textTheme,
                                          employee,
                                        ),

                                        // page delete view
                                        confirmDeletePage(
                                          modalSheetContext,
                                          textTheme,
                                          employee,
                                        ),
                                      ];
                                    },
                                    modalTypeBuilder: (context) {
                                      final size =
                                          MediaQuery.of(context).size.width;
                                      if (size < 400) {
                                        return WoltModalType.bottomSheet;
                                      } else {
                                        return WoltModalType.dialog;
                                      }
                                    },
                                    onModalDismissedWithBarrierTap: () {
                                      debugPrint(
                                          'Closed modal sheet with barrier tap');
                                      Navigator.of(context).pop();
                                      pageIndexNotifier.value = 0;
                                    },
                                    maxDialogWidth: 560,
                                    minDialogWidth: 400,
                                    minPageHeight: 0.0,
                                    maxPageHeight: 0.9,
                                  );
                                },
                                trailing: Card(
                                  color: roleCardColor(employee.role),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(employee.role.toUpperCase()),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 250,
                                    width: 400,
                                    color: Colors.grey.shade200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person_add),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                WoltModalSheet.show<void>(
                                                  pageIndexNotifier:
                                                      pageCreateIndexNotifier,
                                                  context: context,
                                                  barrierDismissible: false,
                                                  pageListBuilder:
                                                      (modalSheetContext) {
                                                    final textTheme =
                                                        Theme.of(context)
                                                            .textTheme;
                                                    return [
                                                      // new staff
                                                      createStaffPage(
                                                          modalSheetContext,
                                                          textTheme,
                                                          compId),
                                                    ];
                                                  },
                                                  modalTypeBuilder: (context) {
                                                    final size =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width;
                                                    if (size < 400) {
                                                      return WoltModalType
                                                          .bottomSheet;
                                                    } else {
                                                      return WoltModalType
                                                          .dialog;
                                                    }
                                                  },
                                                  onModalDismissedWithBarrierTap:
                                                      () {
                                                    debugPrint(
                                                        'Closed modal sheet with barrier tap');
                                                    Navigator.of(context).pop();
                                                    pageCreateIndexNotifier
                                                        .value = 0;
                                                  },
                                                  maxDialogWidth: 560,
                                                  minDialogWidth: 400,
                                                  minPageHeight: 0.0,
                                                  maxPageHeight: 0.9,
                                                );
                                              },
                                              child: const Text("Add Staff"),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "No employees. Please tap + add new staff",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                ),
              ],
            );
          });
        },
        error: (error, stack) {
          debugPrint("$stack");
          return Center(child: Text("$error"));
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

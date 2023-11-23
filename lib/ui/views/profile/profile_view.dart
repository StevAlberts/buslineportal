import 'package:buslineportal/network/services/authentication_service.dart';
import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:buslineportal/shared/models/user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:otp/otp.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/utils/app_color_utils.dart';
import '../../../shared/utils/dynamic_padding.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.company, required this.user})
      : super(key: key);

  final Company company;
  final UserModel user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final pageCreateIndexNotifier = ValueNotifier(0);
  final _formKey = GlobalKey<FormBuilderState>();

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
                // authNotifier.logout();
                authenticationService.logout();
              },
            ),
          ],
        );
      },
    );
  }


  WoltModalSheetPage updateManagerPage(
    BuildContext modalSheetContext,
    TextTheme textTheme,
    String? companyId,
  ) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Manager Details', style: textTheme.titleLarge),
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
                child: FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.alternate_email),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'role',
                  initialValue: 'manager'.toUpperCase(),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    icon: Icon(Icons.security),
                  ),
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
                      var email = _formKey.currentState?.instantValue["email"];
                      var role = 'manager';

                      var employee0 = Staff(
                        id: employeeId,
                        companyId: "$companyId",
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        companyName: widget.company.name,
                        phone: 'null',
                        email: email,
                        role: role,
                        isOnline: false,
                        trips: [],
                      );

                      // send employee invite
                      authenticationService
                          .sendInviteWithEmailLink(employeeId, email)
                          .then((value) {
                        /// TODO: Save staff details to userDB
                        print(employee0.toJson());
                      });

                      // show success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: ListTile(
                            leading: Icon(Icons.check, color: Colors.green),
                            title: Text(
                              "Invite sent",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );

                      // pop sheet
                      Navigator.pop(modalSheetContext);
                      pageCreateIndexNotifier.value = 0;
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("SEND INVITE"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: logoutDialog,
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextAvatar(
                  text: widget.company.name.toUpperCase(),
                  shape: Shape.Circular,
                  numberLetters: 2,
                  upperCase: true,
                  fontSize: 20,
                  size: 100,
                ),
              ),
              ListTile(
                title: Center(child: Text(widget.company.name.toUpperCase())),
                // subtitle: Center(child: Text("${company?.id.toUpperCase()}")),
                subtitle: Center(
                  child: Card(
                    color: roleCardColor(widget.user.role!),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Code: ${widget.company.id}"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              child: TextAvatar(
                text: '${widget.user.firstName} ${widget.user.lastName}'
                    .toUpperCase(),
                shape: Shape.Circular,
                numberLetters: 2,
                upperCase: true,
              ),
            ),
            title: Text("${widget.user.firstName} ${widget.user.lastName}"),
            subtitle: Text("${widget.user.email}"),
            trailing: Card(
              color: roleCardColor(widget.user.email!),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.user.role!.toUpperCase()),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text("Company Managers"),
            trailing: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.icon(
                onPressed: () {
                  WoltModalSheet.show<void>(
                    pageIndexNotifier: pageCreateIndexNotifier,
                    context: context,
                    barrierDismissible: false,
                    pageListBuilder: (modalSheetContext) {
                      final textTheme = Theme.of(context).textTheme;
                      return [
                        // new staff
                        updateManagerPage(
                            modalSheetContext, textTheme, "compId"),
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
                icon: Icon(Icons.add),
                label: const Text("Invite"),
              ),
            ),
          ),
          ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: TextAvatar(
                    text: 'E N'.toUpperCase(),
                    shape: Shape.Circular,
                    numberLetters: 2,
                    upperCase: true,
                  ),
                ),
                title: Text("{employee.firstName} {employee.lastName}"),
                subtitle: Text("ID {employee.id.toUpperCase()}"),
                onTap: () {},
                trailing: Card(
                  color: roleCardColor("employee.role"),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("employee.role.toUpperCase()"),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

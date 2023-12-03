import 'package:buslineportal/network/services/authentication_service.dart';
import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:buslineportal/shared/models/user_model.dart';
import 'package:buslineportal/shared/providers/users/user_provider.dart';
import 'package:buslineportal/ui/widgets/error_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:otp/otp.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../shared/providers/auth/auth_provider.dart';
import '../../../shared/utils/app_color_utils.dart';
import '../../../shared/utils/dynamic_padding.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key, required this.company, required this.user})
      : super(key: key);

  final Company company;
  final UserModel user;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final pageCreateIndexNotifier = ValueNotifier(0);
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> logoutDialog() {
    final authNotifier = ref.read(authProvider.notifier);

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
              child: const Text('CANCEL'), // 07
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
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

                      // send employee invite
                      authenticationService
                          .sendInviteWithEmailLink(employeeId, email)
                          .then((value) {
                        /// Save staff details to userDB
                        var staffData = {
                          "id": employeeId,
                          "email": email,
                          "firstName": firstName,
                          "lastName": lastName,
                          "gender": gender,
                          "role": role,
                          "emailLink": value,
                          "companyId": widget.user.companyId,
                          "timestamp": Timestamp.now(),
                        };
                        databaseService.saveEmployeeInvite(staffData);
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
    final managerStream =
        ref.watch(StreamUserManagersProvider(widget.user.companyId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
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
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextAvatar(
                    text: widget.company.name,
                    shape: Shape.Circular,
                    numberLetters: 2,
                    upperCase: true,
                    fontSize: 30,
                    size: 100,
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        widget.company.name.toUpperCase(),
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Card(
                      color: roleCardColor(widget.user.role!),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.company.id),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("Manage profile and account settings")),
          ),
          const Divider(),
          ListTile(
            leading: CircleAvatar(
              child: TextAvatar(
                text: "${widget.user.firstName} ${widget.user.lastName}",
                shape: Shape.Circular,
                numberLetters: 2,
                upperCase: true,
              ),
            ),
            title: Text("${widget.user.firstName} ${widget.user.lastName}"
                .toUpperCase()),
            subtitle: Text("${widget.user.email}"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text("${widget.user.role?.toUpperCase()}"),
            subtitle: const Text("Roles and Permissions"),
          ),
          const Divider(),
          Visibility(
            visible: widget.user.role == 'admin',
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: const Text("Company Managers"),
                  subtitle: const Text(
                      "Create and invite account managers to the portal"),
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
                                modalSheetContext,
                                textTheme,
                                widget.user.companyId,
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
                            pageCreateIndexNotifier.value = 0;
                          },
                          maxDialogWidth: 560,
                          minDialogWidth: 400,
                          minPageHeight: 0.0,
                          maxPageHeight: 0.9,
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Invite"),
                    ),
                  ),
                ),
                managerStream.when(
                  data: (userManagers) {

                    final filteredList = userManagers?.where((element) => element.uid != widget.user.uid).toList();

                    return ListView.separated(
                      itemCount: filteredList!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var manager = filteredList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: TextAvatar(
                              text: "${manager.firstName} ${manager.lastName}",
                              shape: Shape.Circular,
                              numberLetters: 2,
                              upperCase: true,
                            ),
                          ),
                          title:
                              Text("${manager.firstName} ${manager.lastName}"),
                          subtitle: Text("${manager.email}"),
                          onTap: () {},
                          trailing: Card(
                            color: roleCardColor("${manager.role}"),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${manager.role?.toUpperCase()}"),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    );
                  },
                  error: (error, stack) {
                    return ErrorView(error: error);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

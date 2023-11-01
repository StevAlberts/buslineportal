import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key? key}) : super(key: key);

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  final pageIndexNotifier = ValueNotifier(0);

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      hasSabGradient: false,
      topBarTitle: Text('New Staff', style: textTheme.titleLarge),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'First Name',
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'First Name',
                    hintText: "Enter first name"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Last Name',
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Last Name',
                    hintText: "Enter last name"),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderDropdown<String>(
                name: 'Gender',
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  hintText: "Select gender",
                  icon: Icon(Icons.group),
                ),
                items: ['Male', 'Female']
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Email',
                decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.alternate_email),
                    hintText: 'example@email.com'),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'Phone',
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Phone',
                    hintText: '07XXXXXXXX'),
                onChanged: (val) {
                  print(val); // Print the text value write into TextField
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderDropdown<String>(
                name: 'Role',
                decoration: const InputDecoration(
                  labelText: 'Role',
                  hintText: "Select role",
                  icon: Icon(Icons.security),
                ),
                items: ['Conductor', 'Driver', 'Staff']
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees List"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.lightBlue),
              icon: const Icon(Icons.add),
              label: const Text("New Staff"),
              onPressed: () {
                WoltModalSheet.show<void>(
                  pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  barrierDismissible: false,
                  pageListBuilder: (modalSheetContext) {
                    final textTheme = Theme.of(context).textTheme;
                    return [
                      page1(modalSheetContext, textTheme),
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
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Your names"),
            subtitle: Text("example@email.com"),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(),
              title: const Text("Employee name"),
              subtitle: const Text("example@email.com"),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("Role"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

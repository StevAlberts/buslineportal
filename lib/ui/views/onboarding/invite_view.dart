import 'package:buslineportal/network/services/authentication_service.dart';
import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/dynamic_padding.dart';

class InviteView extends StatelessWidget {
  InviteView({Key? key, required this.staffId}) : super(key: key);
  static String get routeName => 'invite';
  static String get routeLocation => '/$routeName';
  final String? staffId;

  final _formKey = GlobalKey<FormBuilderState>();

  // EXAMPLE: https://buslinego.web.app/invite?id=383761&apiKey=AIzaSyCEy2PWLaGNMNMkXcMEWLh8fxXNEDJsXSs&oobCode=6ZXUVAHzKmD4l7rBbizoPeKYbqvuBW26wSjRbzjeftkAAAGL8LBxWg&mode=signIn&lang=en
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/busline-logo.png",
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "WELCOME TO BUSLINE PORTAL",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lets get you started. Fill in the form then submit and wait for your portal.",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create Manager Account",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormBuilderTextField(
                            name: 'company',
                            decoration: const InputDecoration(
                              labelText: 'Company ID',
                              hintText: 'Enter your company ID',
                              icon: Icon(Icons.numbers),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormBuilderTextField(
                            name: 'email',
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your email',
                              icon: Icon(Icons.alternate_email),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormBuilderTextField(
                            name: 'password',
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              icon: Icon(Icons.password),
                            ),
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(6),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormBuilderTextField(
                            name: 'confirm_password',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              icon: Icon(Icons.password),
                            ),
                            obscureText: true,
                            validator: (value) => _formKey.currentState
                                        ?.fields['password']?.value !=
                                    value
                                ? 'No match'
                                : null,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?"),
                                  TextButton(
                                    onPressed: () =>
                                        context.pushReplacement("/"),
                                    child: const Text("Login"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                var company = _formKey
                                    .currentState?.instantValue["company"];
                                var email = _formKey
                                    .currentState?.instantValue["email"];
                                var password = _formKey
                                    .currentState?.instantValue["password"];

                                print("$staffId\n$company\n$email\n$password");

                                if (staffId != null) {
                                  /// Complete link signup
                                  databaseService
                                      .checkEmployeeInvite(staffId!, email)
                                      .then((staff) {
                                    if (staff != null) {
                                      authenticationService
                                          .handleSignInLink(
                                        id: staffId!,
                                        newPassword: password,
                                        emailAuth: staff["email"],
                                      )
                                          .then((user) {
                                        if (user != null) {
                                          var user0 = UserModel(
                                            companyId: staff["companyId"],
                                            uid: user.uid,
                                            email: staff["email"],
                                            emailVerified: false,
                                            firstName: staff["firstName"],
                                            lastName: staff["lastName"],
                                            photoURL: null,
                                            phoneNumber: staff["phone"],
                                            timestamp: Timestamp.now(),
                                            role: staff["role"],
                                          );
                                          // save user to user db
                                          databaseService.saveUser(
                                            user.uid,
                                            user0,
                                          );
                                          // navigate to home
                                          context.go('/');
                                        }
                                      });
                                    } else {
                                      // User doesnt exist
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "User doesnt exit. Please check your email."),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  // User doesnt exist
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "User doesnt exit. Please check your email."),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('SUBMIT'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "By continuing, you agree to our Terms and Policies."),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

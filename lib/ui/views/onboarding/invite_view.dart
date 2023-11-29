import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/dynamic_padding.dart';

class InviteView extends StatelessWidget {
  InviteView({Key? key}) : super(key: key);

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
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormBuilderTextField(
                            name: 'id',
                            decoration: const InputDecoration(
                              labelText: 'ID Number',
                              hintText: 'Enter your ID Number',
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
                                var id =
                                    _formKey.currentState?.instantValue["id"];
                                var email = _formKey
                                    .currentState?.instantValue["email"];
                                var password = _formKey
                                    .currentState?.instantValue["password"];

                                print("$id\n$email\n$password");

                                /// TODO: Complete link signup
                                /// Then: Signup email and password
                                ///
                                /// Check company address and save details to company mgtRequest
                                /// Create account for user.
                                ///
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

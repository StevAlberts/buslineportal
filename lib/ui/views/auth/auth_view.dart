import 'package:buslineportal/network/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/providers/app_provider.dart';
import '../../../shared/providers/auth/auth_provider.dart';
import '../../../shared/utils/dynamic_padding.dart';

class AuthView extends ConsumerWidget {
  AuthView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    final isLoading = ref.watch(loadingProvider);
    final forgotPass = ref.watch(resetPassProvider);
    final errorMsg = ref.watch(errorMsgProvider);
    final register = ref.watch(contactUsProvider);

    void handleLogin() {
      // Validate and save the form values
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        StateController<bool> load = ref.read(loadingProvider.notifier);
        load.state = true;
        var email = _formKey.currentState?.instantValue["email"];
        var password = _formKey.currentState?.instantValue["password"];

        authNotifier.login(email, password).then((value) {
          StateController<bool> load = ref.read(loadingProvider.notifier);
          load.state = false;
          // show error message
          var errorCode = value[null];
          debugPrint(errorCode);
          StateController<String> error = ref.read(errorMsgProvider.notifier);

          var errorMsg =
              errorCode == "Error" ? "Invalid email or password" : errorCode;
          error.state = errorMsg ?? "";

          if (errorCode == null) {
            context.pushReplacement('/');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 3),
                content: ListTile(
                  leading: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Welcome to Busline Portal.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }

          // stop loading
          load.state = false;
        });
      }
    }

    void registerAccount() {
      // Validate and save the form values
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        StateController<bool> load = ref.read(loadingProvider.notifier);
        load.state = true;

        var firstName = _formKey.currentState?.instantValue["first_name"];
        var lastName = _formKey.currentState?.instantValue["last_name"];
        var email = _formKey.currentState?.instantValue["email"];
        var password = _formKey.currentState?.instantValue["password"];

        authNotifier.signup(email, password).then((value) {
          StateController<bool> load = ref.read(loadingProvider.notifier);
          load.state = false;

          // show error message
          String? errorMsg = value['error'];
          // show user
          User? user = value['user'];

          print("Error: $errorMsg");
          print("User: $user");

          StateController<String> error = ref.read(errorMsgProvider.notifier);
          error.state = errorMsg ?? "";

          if (errorMsg == null && user != null) {
            // update displayName
            user.updateDisplayName("$firstName $lastName");

            // send verification email
            user.sendEmailVerification();

            // store user to db
            authenticationService
                .addUserRequest(user, firstName, lastName)
                .then((value) async {
              if (value) {
                // send verification email.
                await user.sendEmailVerification();
              }
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 10),
                content: SafeArea(
                  child: ListTile(
                    leading: Icon(
                      Icons.auto_awesome,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Welcome to Busline Portal",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );

            StateController<bool> register =
                ref.read(contactUsProvider.notifier);
            register.state = false;
          }

          // stop loading
          load.state = false;
        });
      }
    }

    void handleResetPassword() {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        StateController<bool> load = ref.read(resetPassProvider.notifier);
        load.state = false;
        var email = _formKey.currentState?.instantValue["email"];

        authNotifier.handleForgotPassword(email);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 10),
            content: ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(
                "We sent you a password reset link. Please check your email. $email",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      bottomNavigationBar: const SafeArea(
        child: ListTile(
          dense: true,
          title: Text("Powered by Busline"),
          subtitle: Text("Terms and conditions apply"),
          trailing: Text("Version 0.1.1"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/busline-logo.png",
                    height: 200,
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Busline Portal",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  child: Column(
                    children: [
                      Visibility(
                        visible: forgotPass,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sorry, Forgot your password?",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Enter your email address and we will send you a password reset link.",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: register,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Welcome",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Create an account and we will send you a follow up email to get you started.",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: register,
                            child: Padding(
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
                          ),
                          Visibility(
                            visible: register,
                            child: Padding(
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
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: !forgotPass,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: register,
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
                          ),
                        ],
                      ),
                      Visibility(
                        visible: errorMsg.isNotEmpty,
                        child: Text(
                          errorMsg,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      Visibility(
                        visible: !register && !forgotPass,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              StateController<bool> load =
                                  ref.read(resetPassProvider.notifier);
                              load.state = true;
                            },
                            child: const Text("Forgot your password?"),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: register || forgotPass,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                StateController<bool> load0 =
                                    ref.read(contactUsProvider.notifier);
                                load0.state = false;
                                StateController<bool> load1 =
                                    ref.read(resetPassProvider.notifier);
                                load1.state = false;
                              },
                              child: const Text("Login"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: !register && !forgotPass,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : FilledButton(
                                  onPressed: handleLogin,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Login'),
                                  ),
                                ),
                        ),
                      ),
                      Visibility(
                        visible: forgotPass,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: FilledButton(
                              onPressed: handleResetPassword,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Send'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: register,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: FilledButton(
                              onPressed: registerAccount,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Register'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: !register && !forgotPass,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Need account?"),
                              TextButton(
                                onPressed: () {
                                  StateController<bool> load =
                                      ref.read(contactUsProvider.notifier);
                                  load.state = true;
                                },
                                child: const Text("Contact Us"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

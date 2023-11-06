import 'package:buslineportal/network/services/authentication_service.dart';
import 'package:buslineportal/network/services/database_services.dart';
import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/shared/models/user_model.dart';
import 'package:buslineportal/shared/models/user_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/auth/auth_provider.dart';

class OnboardCompanyProfile extends ConsumerWidget {
  OnboardCompanyProfile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final authNotifier = ref.read(authProvider.notifier);

    final userRepository = FirebaseFirestore.instance
        .collection('requests')
        .doc(firebaseUser?.uid ?? "")
        .snapshots();

    return Scaffold(
      // appBar: AppBar(title: const Text("Busline Portal"),),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userRepository,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data?.data() as Map?;

            UserRequestModel? userData = UserRequestModel.fromJson(user);

            // bool isGranted = user["isGranted"];
            // String userId = user["uid"];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Busline Portal",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !userData.isGranted! ,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Hi, ${userData.firstName}",
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Thank you for apply to Busline. We will get back to you as soon as possible.",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
                                TextButton(
                                  onPressed: () => authNotifier.logout(),
                                  child: const Text("Login"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: userData.isGranted ?? false ,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("WELCOME TO THE PORTAL",
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    name: 'company',
                                    decoration: const InputDecoration(
                                      labelText: 'Company Name',
                                      icon: Icon(Icons.store),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    name: 'address',
                                    decoration: const InputDecoration(
                                        labelText: 'Company Addresses',
                                        icon: Icon(Icons.location_on),
                                        hintText: "Eg: City A, City B"),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    name: 'phone',
                                    decoration: const InputDecoration(
                                      labelText: 'Company Phone',
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
                                    // onChanged: (value) => phoneNotifier.value = value!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    name: 'email',
                                    decoration: const InputDecoration(
                                      labelText: 'Company Email',
                                      icon: Icon(Icons.alternate_email),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.email(),
                                    ]),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "By continuing, you agree to our Terms and Policies."),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FilledButton(
                                    onPressed: () {
                                      if (_formKey.currentState
                                              ?.saveAndValidate() ??
                                          false) {
                                        var company = _formKey.currentState
                                            ?.instantValue["company"];
                                        var address = _formKey.currentState
                                            ?.instantValue["address"];
                                        var phone = _formKey.currentState
                                            ?.instantValue["phone"];
                                        var email = _formKey.currentState
                                            ?.instantValue["email"];

                                        var uuid = const Uuid().v4();
                                        var uuidString = uuid.toString();
                                        var shortUUIDPrefix =
                                            uuidString.substring(0, 6);

                                        // create user
                                        var userModel = UserModel(
                                          uid: userData.uid,
                                          email: userData.email,
                                          emailVerified: userData.emailVerified,
                                          lastName: userData.lastName,
                                          firstName: userData.firstName,
                                          phoneNumber:
                                              userData.phoneNumber ?? phone,
                                          photoURL: userData.photoURL,
                                          role: "admin",
                                          companyIds: [shortUUIDPrefix],
                                        );

                                        // create company
                                        var company0 = Company(
                                          id: shortUUIDPrefix,
                                          ownerId: userData.uid ?? "",
                                          name: company,
                                          address: address,
                                          contact: phone,
                                          email: email,
                                          imgUrl: "",
                                          fleet: [],
                                          destinations: [],
                                        );

                                        // save details
                                        databaseService
                                            .createCompanyProfile(company0);

                                        // create user
                                        authenticationService
                                            .createUserProfile(userModel);

                                        // show success
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: ListTile(
                                              leading: Icon(Icons.auto_awesome,
                                                  color: Colors.green),
                                              title: Text(
                                                "New company profile created",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('SUBMIT'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle the error here.
            return Center(child: Text("${snapshot.error}"));
          } else {
            // Show a loading indicator here.
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

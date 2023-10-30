import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProfileView extends StatelessWidget {
  CreateProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: "yourFirstName");
  final _lastNameController = TextEditingController(text: "yourLastName");
  final _emailController = TextEditingController(text: "yourEmail");
  final _companyNameController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _companyPhoneController = TextEditingController();
  final _companyEmailController =
      TextEditingController(text: "buscompany@email.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Register a profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            labelText: 'First Name', icon: Icon(Icons.person)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a first name.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                            labelText: 'Last Name', icon: Icon(Icons.person_2)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a last name.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: ' Email Address',
                            icon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a your email address.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: _companyNameController,
                      decoration: const InputDecoration(
                          hintText: "Enter name of your company",
                          labelText: 'Company Names',
                          icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a company name.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _companyAddressController,
                      decoration: const InputDecoration(
                          hintText:
                              "Enter locations of your offices e.g: City A, City B",
                          labelText: 'Company Address',
                          icon: Icon(Icons.location_on)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a company address.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _companyPhoneController,
                      decoration: const InputDecoration(
                        label: Text("Company Phone Number"),
                        hintText: "07XXXXXXXX",
                        icon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _companyEmailController,
                      decoration: const InputDecoration(
                          hintText: "exmaple@email.com",
                          labelText: 'Company Email Address',
                          icon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a company email address.';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Submit the form data to the server.
                Router.neglect(context, () {
                  context.go('/dashboard');
                });
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('REGISTER'),
            ),
          ),
        ],
      ),
    );
  }
}

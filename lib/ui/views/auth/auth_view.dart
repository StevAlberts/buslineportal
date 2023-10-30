import 'package:buslineportal/ui/views/app_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircleAvatar(radius: 70)),
              ),
              Text(
                "Busline Portal",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    hintText: "example@email.com",
                    icon: Icon(Icons.alternate_email),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "***********",
                    labelText: 'Password',
                    icon: Icon(Icons.password),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password.';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Forgot your password?"),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  Router.neglect(context, () {
                    context.go('/dashboard');
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Login"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Need an account?"),
                  TextButton(
                    onPressed: () {
                      context.go('/create_profile');
                    },
                    child: const Text("Contact Us"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

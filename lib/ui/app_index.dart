import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/providers/auth/auth_provider.dart';

class AppIndex extends ConsumerWidget {
  const AppIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(firebaseUserProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: userProvider.when(
          data: (user) {
            // The user is authenticated.
            return Text('Welcome, ${user?.displayName}');
          },
          error: (e, s) {
            // An error occurred.
            return Text('An error occurred: ${e}');
          },
          loading: () {
            // The stream is loading.
            return Text('Loading...');
          },
        ),
      ),
    );

  }
}

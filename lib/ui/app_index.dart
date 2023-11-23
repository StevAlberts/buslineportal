import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:buslineportal/ui/views/onboarding/onboarding_company_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/providers/users/user_provider.dart';

class AppIndex extends ConsumerWidget {
  const AppIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final streamUser = ref.watch(StreamCurrentUserProvider(firebaseUser?.uid));

    final userRepository = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid)
        .snapshots();

    final streamUserRequest =
        ref.watch(StreamUserRequestProvider(firebaseUser?.uid));

    return streamUser.when(
      data: (user) {
        // The user is authenticated.
        return StreamBuilder<DocumentSnapshot>(
          stream: userRepository,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!.data();

              // check if account available
              return user == null
                  ?  OnboardCompanyProfile()
                  : const DashboardView();
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
        );
      },
      error: (error, stack) {
        debugPrint("$stack");
        return Material(
          child: Center(
            child: Text("$error"),
          ),
        );
      },
      loading: () => const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

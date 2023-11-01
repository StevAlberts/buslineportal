import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/providers/auth/auth_provider.dart';

class AppIndex extends ConsumerWidget {
  const AppIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(),
      body:
          userProvider != null ? const Text("Hello") : const Text("Null User"),
    );
  }
}

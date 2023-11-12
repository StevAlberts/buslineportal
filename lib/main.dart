import 'package:buslineportal/shared/routes/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'shared/providers/auth/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instance;
  // Disable persistence on web platforms. Must be called on initialization:
  await auth.setPersistence(Persistence.NONE);

  // Both of the following lines are good for testing,
  // but can be removed for release builds
  if (kDebugMode) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await auth.setPersistence(Persistence.SESSION);
    // FirebaseAuth.instance.signOut();
  }

  // use path for web
  usePathUrlStrategy();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(firebaseUserProvider);

    return MaterialApp.router(
      title: 'Busline Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        // scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          centerTitle: false,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      // routerConfig: appRouterConfig(firebaseUser),
      routerConfig: firebaseUser.when(
        data: (user) => appRouterConfig(user),
        error: (error, stack) => appRouterConfig(null),
        loading: () => appRouterConfig(null),
      ),
    );
  }
}

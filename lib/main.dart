import 'package:buslineportal/shared/routes/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

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
  // if (kDebugMode) {
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseAuth.instance.signOut();
  // }

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      title: 'Busline Portal',
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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      routerConfig: appRouter(),
    );
  }
}

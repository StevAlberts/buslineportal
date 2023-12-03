import 'package:buslineportal/shared/providers/auth/auth_provider.dart';
import 'package:buslineportal/ui/views/app_view.dart';
import 'package:buslineportal/ui/views/auth/auth_view.dart';
import 'package:buslineportal/ui/views/inventory/inventories_view.dart';
import 'package:buslineportal/ui/views/onboarding/invite_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../ui/views/onboarding/splash_view.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(firebaseUserProvider);

  return GoRouter(
      navigatorKey: _key,
      initialLocation: SplashView.routeLocation,
      routes: [
        GoRoute(
          path: AppView.routeLocation,
          name: AppView.routeName,
          builder: (context, state) {
            return const AppView();
          },
          redirect: (_, state) {
            // If our async state is loading, don't perform redirects, yet
            if (authState.isLoading || authState.hasError) return null;
            // Here we guarantee that hasData == true, i.e. we have a readable value
            // This has to do with how the FirebaseAuth SDK handles the "log-in" state
            // Returning `null` means "we are not authorized"
            final isAuth = authState.valueOrNull != null;
            return isAuth ? null : AuthView.routeLocation;
          },
        ),
        GoRoute(
          path: AuthView.routeLocation,
          name: AuthView.routeName,
          builder: (context, state) {
            return AuthView();
          },
        ),
        GoRoute(
            path: SplashView.routeLocation,
            name: SplashView.routeName,
            builder: (context, state) {
              return const SplashView();
            },
            redirect: (_, state) {
              final isAuth = authState.valueOrNull != null;

              return isAuth ? AppView.routeLocation : AuthView.routeLocation;
            }),
        GoRoute(
          name: InviteView.routeName,
          path: '${InviteView.routeLocation}/:idt&oobCode',
          // https://buslinego.web.app/invite/858998?apiKey=AIzaSyCEy2PWLaGNMNMkXcMEWLh8fxXNEDJsXSs&oobCode=sOq3uL2G4J4XIHkC0EzfJaGS5QyGM8nznL2rOrMIz88AAAGMMB4QlA&mode=signIn&lang=en

          builder: (context, state) {
            // use state.queryParams to get invite id from id parameter
            final id = state.pathParameters['id']; // may be null

            return InviteView(
              staffId: id,
            );
          },
        ),
      ],
      redirect: (context, state) {
        // If our async state is loading, don't perform redirects, yet
        if (authState.isLoading || authState.hasError) return null;
        // Here we guarantee that hasData == true, i.e. we have a readable value
        // This has to do with how the FirebaseAuth SDK handles the "log-in" state
        // Returning `null` means "we are not authorized"
        final isAuth = authState.valueOrNull != null;

        final isSplash = state.name == SplashView.routeName;
        if (isSplash) {
          return isAuth ? AppView.routeLocation : AuthView.routeLocation;
        }

        final isLoggingIn = state.name == AuthView.routeName;
        if (isLoggingIn) return isAuth ? AppView.routeLocation : null;

        // return isAuth ? null : AuthView.routeLocation;
        return null;
      },
      errorPageBuilder: (_, state) {
        return const MaterialPage(child: SplashView());
      });
});

import 'package:buslineportal/ui/app_index.dart';
import 'package:buslineportal/ui/views/app_view.dart';
import 'package:buslineportal/ui/views/auth/auth_view.dart';
import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:buslineportal/ui/views/inventory/inventories_view.dart';
import 'package:buslineportal/ui/views/tickets/luggage_ticket_details_view.dart';
import 'package:buslineportal/ui/views/tickets/passenger_ticket_details_view.dart';
import 'package:buslineportal/ui/views/onboarding/invite_view.dart';
import 'package:buslineportal/ui/views/profile/create_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

appRouterConfig(User? firebaseUser) => GoRouter(
      initialLocation: '/',
      redirect: (_, state) {
        print("Re: ${state.matchedLocation}");

        if (state.matchedLocation == '/invite') {
          print("Lets invite");
          return '/invite';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AppView(),
          redirect: (_, state) {
            print("home");
            print(state.matchedLocation);
            print(firebaseUser?.email);
            if (firebaseUser == null) {
              return state.namedLocation('login');
            }
            return null;
          },
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => AuthView(),
          // redirect: (_, state) {
          //   print("mathc");
          //   print(state.matchedLocation);
          //   return state.namedLocation('invite');
          // }
        ),
        GoRoute(
          path: '/invite',
          name: 'invite',
          builder: (context, state) => InviteView(),
          redirect: (_, state) {
            print(state.fullPath);
            return null;
          },
        ),
      ],
    );

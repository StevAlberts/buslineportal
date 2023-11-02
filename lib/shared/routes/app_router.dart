// GoRouter configuration
import 'package:buslineportal/ui/views/auth/auth_view.dart';
import 'package:buslineportal/ui/views/dashboard/home_view.dart';
import 'package:buslineportal/ui/views/employees/employee_view.dart';
import 'package:buslineportal/ui/views/inventory/inventories_view.dart';
import 'package:buslineportal/ui/views/journeys/journey_details_view.dart';
import 'package:buslineportal/ui/views/journeys/journey_view.dart';
import 'package:buslineportal/ui/views/tickets/luggage_ticket_details_view.dart';
import 'package:buslineportal/ui/views/tickets/luggage_tickets_view.dart';
import 'package:buslineportal/ui/views/tickets/passenger_ticket_details_view.dart';
import 'package:buslineportal/ui/views/tickets/passenger_tickets_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../ui/views/profile/create_profile_view.dart';


appRouterConfig(User? firebaseUser) => GoRouter(
      initialLocation: firebaseUser == null ? '/login' : '/',
      redirect: (context, GoRouterState state) {
        print("firebaseCurrentUser: ${FirebaseAuth.instance.currentUser?.email}");
        if (firebaseUser == null) {
          return '/login';
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => AuthView(),
        ),
        GoRoute(
          path: '/create_profile',
          builder: (context, state) => CreateProfileView(),
        ),
        GoRoute(
          path: '/employees',
          builder: (context, state) => const EmployeeView(),
        ),
        GoRoute(
          path: '/journeys',
          builder: (context, state) => const JourneyView(),
        ),
        GoRoute(
          path: '/journey_details',
          builder: (context, state) => const JourneyDetailsView(),
        ),
        GoRoute(
          path: '/inventories',
          builder: (context, state) => const InventoriesView(),
        ),
        GoRoute(
          path: '/passengers',
          builder: (context, state) => const PassengerTicketsView(),
        ),
        GoRoute(
          path: '/passenger_details',
          builder: (context, state) => const PassengerTicketDetailsView(),
        ),
        GoRoute(
          path: '/luggage',
          builder: (context, state) => const LuggageTicketsView(),
        ),
        GoRoute(
          path: '/luggage_details',
          builder: (context, state) => const LuggageTicketDetailsView(),
        ),
        GoRoute(
          path: '/report',
          builder: (context, state) => const InventoriesView(),
        ),
      ],
    );

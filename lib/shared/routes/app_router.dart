// GoRouter configuration
import 'package:buslineportal/ui/app_index.dart';
import 'package:buslineportal/ui/views/auth/auth_view.dart';
import 'package:buslineportal/ui/views/dashboard/dashboard_view.dart';
import 'package:buslineportal/ui/views/inventory/inventories_view.dart';
import 'package:buslineportal/ui/views/tickets/luggage_ticket_details_view.dart';
import 'package:buslineportal/ui/views/tickets/passenger_ticket_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../ui/views/onboarding/invite_view.dart';
import '../../ui/views/profile/create_profile_view.dart';

appRouterConfig(User? firebaseUser) => GoRouter(
      // log diagnostic info for your routes
      debugLogDiagnostics: true,
      initialLocation: '/',
      redirect: (context, GoRouterState state) {

        // return firebaseUser != null ? null : '/login';

        if (firebaseUser != null) {
          return null;
        } else {
          return '/login';
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AppIndex(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => AuthView(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardView(),
        ),
        GoRoute(
          path: '/create_profile',
          builder: (context, state) => CreateProfileView(),
        ),
        GoRoute(
          path: '/invite/:id',
          builder: (context, state) => InviteView(),
        ),
        // GoRoute(
        //   path: '/users',
        //   builder: (context, state) => const UsersScreen(filter: state.uri.queryParameters['filter']),
        // ),
        // GoRoute(
        //   path: '/journeys',
        //   builder: (context, state) => const JourneyView(),
        // ),
        // GoRoute(
        //   path: '/journey_details',
        //   builder: (context, state) => const JourneyDetailsView(),
        // ),
        // GoRoute(
        //   path: '/employees',
        //   builder: (context, state) {
        //     final tripId = state.pathParameters['company'];
        //     final trips = state.extra as Company;
        //     // Get the trip object from the list of trips.
        //     final trip = trips?.firstWhere((trip) => trip.id == tripId);
        //
        //     // Return the JourneyDetailsPage widget.
        //     return JourneyDetailsView(trip: trip);
        //   },
        // ),
        GoRoute(
          path: '/inventories',
          builder: (context, state) => const InventoriesView(),
        ),
        // GoRoute(
        //   path: '/passengers',
        //   builder: (context, state) => const PassengerTicketsView(),
        // ),
        GoRoute(
          path: '/passenger_details',
          builder: (context, state) => const PassengerTicketDetailsView(),
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

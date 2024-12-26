import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/coordinator/show_volunteers/volunteers_page.dart';
import 'package:orot/pages/login/login_page.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';

GoRouter getConfigRouter() {
  final User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  Fluttertoast.showToast(msg: '$user');
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) {
      if (user == null) {
        return '/login';
      } else {
        //ITAMAR IF YOU WANT TO CHANGE PAGES YOU CAN DO IT HERE!
        return '/volunteer/home'; //TODO: when logged in check if user is volunteer or coordinator and send to its root route.
      }
      //TODO: manage admin access here
      // if (state.uri.toString().startsWith('/admin') && user is not admin ) {
      //   return '/home';
      // }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      adminRoutes(),
      volunteerRoutes(rootNavigatorKey),
      coordinatorRoutes(),
    ],
  );
}

GoRoute volunteerRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
  return GoRoute(
    path: '/volunteer',
    builder: (context, state) => const HomePage(),
    routes: [
      ShellRoute(
        navigatorKey: rootNavigatorKey,
        builder: (context, state, child) {
          return VolunteerNavigation();
        },
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'history',
            builder: (context, state) => const VisitsHistoryPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

GoRoute adminRoutes() {
  return GoRoute(
    path: '/admin',
    builder: (context, state) => const AdminPage(),
  );
}

GoRoute coordinatorRoutes() {
  return GoRoute(
    path: '/coordinator',
    builder: (context, state) => const VolunteersPage(),
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/login/login_page.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';

GoRouter getConfigRouter() {
  final User? user = FirebaseAuth.instance.currentUser;

  return GoRouter(
    redirect: (context, state) {
      if (user == null) {
        return '/login';
      }
      //TODO: when logged in check if user is volunteer or coordinator and send to its root route.

      //TODO: manage admin access here
      // if (state.uri.toString().startsWith('/admin') && user is not admin ) {
      //   return '/home';
      // }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
        ],
      ),
    ],
  );
}

GoRoute volunteerRoutes() {
  return GoRoute(
    path: 'volunteer',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'visit',
      ),
      GoRoute(
        path: 'reminder',
      ),
      GoRoute(
        path: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}

GoRoute adminRoutes() {
  return GoRoute(
    path: 'admin',
    builder: (context, state) => const AdminPage(),
  );
}

GoRoute coordinatorRoutes() {
  return GoRoute(
    path: 'coordinator',
    builder: /* point to coordinator homepage */ null,
  );
}
